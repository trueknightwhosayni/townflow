class Anything::FormObject
  include ActiveModel::Model

  attr_accessor :title, :fields, :collection_id, :form_record

  delegate :persisted?, to: :@form_record, allow_nil: true

  validates :title, :collection_id, presence: true
  validate :ensure_all_fields_valid

  def self.find(id)
    form_record = Anything::Form.find(id)

    form = Neewom::CustomForm.find_by!(key: form_key(form_record.id)).to_form

    fields = form.fields
      .reject { |field| field.name.to_sym == :commit }
      .map { |field| Anything::FormFieldObject.from_neewom_field(field) }

    new(
      form_record: form_record,
      title: form_record.title,
      collection_id: form_record.collection_id,
      raw_fields: fields
    )
  end

  def self.form_key(id)
    "anything_form_#{id}"
  end

  def fields
    @fields || []
  end

  def fields=(value)
    @fields = Array.wrap(value).map { |raw| Anything::FormFieldObject.new(raw) }
  end

  def raw_fields=(fields)
    @fields = fields
  end

  def save
    return false unless valid?

    collection_record = Anything::Collection.find(collection_id)

    @form_record ||= Anything::Form.new
    @form_record.update!(title: title, collection: collection_record)

    repository_klass = @form_record.collection.system_class_name || ::Anything::GodRecord.name
    form_fields = [[:commit, { label: 'Save', input: 'submit' }]] + fields.map(&:to_neewom_field)

    form = Neewom::AbstractForm.build(
      id: self.class.form_key(@form_record.id),
      repository_klass: repository_klass,
      fields: form_fields.to_h
    )

    form.store!
    actualize_fields_records(collection_record)

    true
  end

  def destroy
    # TODO: put this logic inside gem
    neewom_form_record = Neewom::CustomForm.find_by!(key: self.class.form_key(@form_record.id))
    neewom_form_record.custom_fields.each(&:destroy)
    neewom_form_record.destroy

    @form_record.destroy

    true
  end

  private

  def actualize_fields_records(collection_record)
    fields.each { |f| f.save!(collection_record.id) }

    existing_names =
      collection_record.forms
        .pluck(:id)
        .map { |id| Neewom::CustomForm.find_by!(key: Anything::FormObject.form_key(id)).to_form }
        .map { |neewom_form| neewom_form.fields.map(&:name) }
        .flatten

    collection_record.fields.where.not(name: existing_names).delete_all
  end

  def ensure_all_fields_valid
    return if @fields.blank?
    return if @fields.map(&:valid?).all?

    errors.add :validations, "Fields invalid"
  end
end

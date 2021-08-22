class Anything::FormObject
  include ActiveModel::Model

  attr_accessor :title, :fields, :collection_id, :form_record

  delegate :persisted?, to: :@form_record, allow_nil: true

  validates :title, :collection_id, presence: true
  validate :ensure_all_fields_valid

  def self.find(id)
    form_record = Anything::Form.find(id)

    form = form_record.to_neewom_form

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
      id: @form_record.form_key,
      repository_klass: repository_klass,
      fields: form_fields.to_h
    )

    form.store!
    actualize_fields_records(collection_record)

    true
  end

  def destroy
    @form_record.destroy_with_dependencies

    true
  end

  private

  def actualize_fields_records(collection_record)
    fields.each { |f| f.save!(collection_record.id) }

    existing_names =
      collection_record.forms
        .map(&:to_neewom_form)
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

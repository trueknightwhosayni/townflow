class Anything::FormFieldObject
  include ActiveModel::Model

  attr_accessor :name, :label, :field_type, :input, :collection, :virtual, :input_html

  validates :name, :label, :field_type, :input, presence: true
  validates :name, system_name: true
  validates :collection, presence: true, if: -> { field_type == Anything::Managers::Form::FIELD_TYPE_RELATION }

  def save!(collection_id)
    Anything::Field
      .where(collection_id: collection_id, name: name)
      .first_or_initialize
      .update!(
        title: label,
        field_data_type: field_type,
      )
  end

  def validations
    @validations || []
  end

  def validations=(value)
    @validations = Array(value).map { |raw| Anything::FormFieldValidationObject.new(raw) }
  end

  def to_neewom_field
    collection_config =
      if field_type == Anything::Managers::Form::FIELD_TYPE_RELATION
        {
          collection_klass: Anything::Managers::Relation,
          collection_method: :build_relation,
          collection_params: Anything::Managers::Relation.serialize_params(collection),
        }
      else
        {}
      end

    [
      name,
      {
        virtual: virtual,
        label: label,
        input: input,
        input_html: input_html,
        validations: validations.map { |v| v.to_neewom_validation },
        custom_options: { field_type: field_type },
      }.merge(collection_config)
    ]
  end

  def self.from_neewom_field(field)
    new({
      name: field.name,
      virtual: field.virtual,
      label: field.label,
      input: field.input,
      input_html: field.input_html,
      validations: field.validations.map { |v| v.to_neewom_validation },
      field_type: field.custom_options[:field_type],
    })
  end
end

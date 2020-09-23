class Anything::FormFieldObject
  include ActiveModel::Model

  attr_accessor :name, :label, :field_type, :input, :collection, :virtual, :input_html

  validates :name, :label, :field_type, :input, presence: true
  validates :name, system_name: true
  validates :collection, presence: true, if: -> { field_type == Anything::Managers::Form::FIELD_TYPE_RELATION }

  def validations
    @validations || []
  end

  def validations=(value)
    puts value.inspect
    @validations = Array(value).map { |raw| Anything::FormFieldValidationObject.new(raw) }
  end
end
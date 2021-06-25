class Anything::FormFieldValidationObject
  include ActiveModel::Model

  attr_accessor :name, :params, :options

  validates :name, presence: true, inclusion: {in: Anything::Managers::FormFieldValidation::SUPPORTED_VALIDATIONS}

  def options
    @options || {}
  end

  def params
    @params || {}
  end

  def to_neewom_validation
  end

  def self.from_neewom_validation
  end
end

class Anything::FormFieldValidationObject
  include ActiveModel::Model

  attr_accessor :name, :params, :options

  validates :name, presence: true, inclusion: { in: Anything::Managers::FormFieldValidation::SUPPORTED_VALIDATIONS }

  def options
    @options || {}
  end

  def params
    @params || {}
  end

  def to_neewom_validation
    params.merge(options)
  end

  def self.from_neewom_validation(neewom_validations)
    name = Anything::Managers::FormFieldValidation::SUPPORTED_VALIDATIONS.find { |allowed_validation| neewom_validations.keys.map(&:to_s).include?(allowed_validation) }

    params = neewom_validations.dup.symbolize_keys
    options = {}

    %i[allow_nil allow_blank message on].each do |option|
      options[option] = params.delete(option) if params.has_key?(option)
    end

    new(name: name, params: params, options: options)
  end
end

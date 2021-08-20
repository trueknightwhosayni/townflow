class Anything::FormFieldValidationObject
  include ActiveModel::Model

  M = Anything::Managers::FormFieldValidation

  attr_accessor :name, :params, :options

  validates :name, presence: true, inclusion: { in: Anything::Managers::FormFieldValidation::SUPPORTED_VALIDATIONS }
  validate :ensure_length_validation_options, if: -> { name == M::VALIDATION_LENGTH }
  validate :ensure_numericality_validation_options, if: -> { name == M::VALIDATION_NUMERICALITY }

  def options
    @options && @options.deep_symbolize_keys|| {}
  end

  def params
    @params && @params.deep_symbolize_keys || {}
  end

  def to_neewom_validation
    sanitized_params = (params.presence || {}).reject { |_, v| v.blank? }

    { name.to_sym => sanitized_params.presence || true }.merge(options)
  end

  def self.from_neewom_validation(neewom_validations)
    name = Anything::Managers::FormFieldValidation::SUPPORTED_VALIDATIONS
            .find { |allowed_validation| neewom_validations.keys.map(&:to_s).include?(allowed_validation) }

    data = neewom_validations.dup.symbolize_keys

    params = data.delete(name.to_sym)
    params = {} if params == true
    options = {}

    %i[allow_nil allow_blank message on].each do |option|
      options[option] = data.delete(option) if data.has_key?(option)
    end

    new(name: name, params: params, options: options)
  end

  private

  def ensure_length_validation_options
    ensure_params_in_list(M::LENGTH_PARAMS_LIST)
  end

  def ensure_numericality_validation_options
    ensure_params_in_list(M::NUMERICALITY_PARAMS_LIST)
  end

  def ensure_params_in_list(list)
    return if params.present? && params.slice(*list).values.any?(&:present?)

    errors.add :params, "At least one of #{list} should present for the #{name} validation"
  end
end

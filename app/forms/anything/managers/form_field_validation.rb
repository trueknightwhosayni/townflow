class Anything::Managers::FormFieldValidation
  SUPPORTED_VALIDATIONS = [
    VALIDATION_PRESENCE = 'presence',
    # VALIDATION_FORMAT = 'format',
    VALIDATION_NUMERICALITY = 'numericality',
    VALIDATION_LENGTH = 'length'
  ]

  LENGTH_PARAMS_LIST = %i[minimum maximum is]
  NUMERICALITY_PARAMS_LIST = %i[only_integer odd even greater_than greater_than_or_equal_to less_than less_than_or_equal_to other_than equal_to]

  def self.validations_list_options
    SUPPORTED_VALIDATIONS.map { |t| [t.capitalize, t] } # TODO Add I18n here
  end

  def self.all_possible_permitted_params
    # %i(with) + # format
    LENGTH_PARAMS_LIST +
    NUMERICALITY_PARAMS_LIST
  end
end

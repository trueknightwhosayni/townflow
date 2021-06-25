class Anything::Managers::FormFieldValidation
  SUPPORTED_VALIDATIONS = [
    VALIDATION_PRESENCE = 'presence',
    # VALIDATION_FORMAT = 'format',
    VALIDATION_NUMERICALITY = 'numericality',
    VALIDATION_LENGTH = 'length'
  ]

  def self.validations_list_options
    SUPPORTED_VALIDATIONS.map { |t| [t.capitalize, t] } # TODO Add I18n here
  end

  def self.all_possible_permitted_params
    %i(with) + # format
    %i(minimum maximum is) + # length
    %i(only_integer greater_than greater_than_or_equal_to equal_to less_than less_than_or_equal_to other_than odd even) # numericality
  end
end
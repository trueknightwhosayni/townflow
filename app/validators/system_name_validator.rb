
class SystemNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^([a-z|_|0-9])+$/
      record.errors[attribute] << (options[:message] || "not valid name (use only lowercase letters and underscores)")
    end
  end
end

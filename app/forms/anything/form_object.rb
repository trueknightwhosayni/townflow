class Anything::FormObject
  include ActiveModel::Model

  attr_accessor :title, :fields

  delegate :persisted?, to: :@form_record, allow_nil: true

  validates :title, presence: true
  validate :ensure_all_fields_valid

  def self.find(id)
    @form_record = Anything::Form.find(id)
  end

  def fields
    @fields || build_dummy_fields
  end

  def fields=(value)
    @fields = Array(value).map { |raw| Anything::FormFieldObject.new(raw) }
  end

  def record_id
    @form_record.id
  end

  def save
    return false unless valid?

    true
  end

  def destroy
    true
  end

  private

  def ensure_all_fields_valid
    @fields && @fields.map(&:valid?).all?
  end

  def build_dummy_fields
    result = []

    1.times do |i|
      result << Anything::FormFieldObject.new({:name => "dummy_name_#{i}", :label => "Dummy label #{i}",
        :input => "dummy_input", :collection => "dummy collection #{i}", :virtual => true, :input_html => "",
        validations: [
          {
            "name" => 'length',
            "params" => {},
            "options" => { allow_blank: false }
          },
          {
            "name" => 'presence',
            "params" => {},
            "options" => { allow_blank: false, on: 'create' }
          }
        ]
      })
    end

    result
  end
end
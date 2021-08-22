class Anything::Managers::Form
  FIELD_TYPES = [
    FIELD_TYPE_INTEGER = 'integer',
    FIELD_TYPE_FLOAT = 'float',
    FIELD_TYPE_TEXT = 'text',
    FIELD_TYPE_BOOL = 'bool',
    FIELD_TYPE_FILE = 'file',
    FIELD_TYPE_DATETIME = 'datetime',
    FIELD_TYPE_RELATION = 'relation'
  ]

  AF = Neewom::AbstractField
  FIELD_INPUTS = AF::SUPPORTED_FIELDS

  FIELD_INPUTS_BY_TYPES = {
    FIELD_TYPE_INTEGER => [AF::NUMBER, AF::TEXT],
    FIELD_TYPE_FLOAT => [AF::TEXT],
    FIELD_TYPE_TEXT => [AF::TEXT, AF::TEXTAREA, AF::EMAIL, AF::PHONE],
    FIELD_TYPE_BOOL => [AF::CHECKBOX],
    FIELD_TYPE_FILE => [AF::FILE],
    FIELD_TYPE_DATETIME => [AF::DATEPICKER, AF::TIMEPICKER, AF::DATETIMEPICKER],
    FIELD_TYPE_RELATION => [AF::SELECT, AF::MULTIPLE_SELECT]
  }

  def self.field_type_options
    FIELD_TYPES.map { |t| [t.capitalize, t] } # TODO Add I18n here
  end

  def self.input_options(field_type)
    FIELD_INPUTS_BY_TYPES[field_type].map { |t| [t.humanize, t] } # TODO Add I18n here
  end

  def self.collections_list_options
    @collections_list_options ||=
      Anything::Collection.all.map { |collection| [collection.title, collection.id] }
  end

  def self.list_views_options(collection_id)
    collection = Anything::Collection.find(collection_id)

    collection.views.list.map { |view| [view.title, view.id] }
  end

  def self.document_views_options(collection_id)
    collection = Anything::Collection.find(collection_id)

    collection.views.document.map { |view| [view.title, view.id] }
  end

  def self.forms_options(collection_id)
    collection = Anything::Collection.find(collection_id)

    collection.forms.map { |form| [form.title, form.id] }
  end
end

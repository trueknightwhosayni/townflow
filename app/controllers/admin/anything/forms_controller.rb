class Admin::Anything::FormsController < Admin::Anything::BaseController

  def index
  end

  def new
    @form_object = ::Anything::FormObject.new
  end

  def create
    @form_object = ::Anything::FormObject.new(permitted_params)

    if @form_object.save
      redirect_to back_path
    else
      render :new
    end
  end

  def edit
    @form_object = ::Anything::FormObject.find(params[:id])
  end

  def update
    @form_object = ::Anything::FormObject.find(params[:id])
    @form_object.assign_attributes(permitted_params)

    if @form_object.save
      redirect_to back_path
    else
      render :edit
    end
  end

  def destroy
    ::Anything::FormObject.find(params[:id]).destroy

    redirect_to back_path
  end

  private

  def collection_record
    @collection_record ||= ::Anything::Collection.find(params[:collection_id])
  end
  helper_method :collection_record

  def back_path
    admin_anything_collection_forms_path(collection_record)
  end
  helper_method :back_path

  def permitted_params
    params.require(:form).permit(:title, :collection_id, fields: [:name, :label, :field_type, :input, :collection, :virtual, :input_html,
    validations: [:name, :options => [:allow_blank, :on], :params => Anything::Managers::FormFieldValidation.all_possible_permitted_params]
    ])
  end

  def current_tab_pane
    :forms
  end
end

class AtRecordsController < ApplicationController
  def index
    @renderer = section.list_renderer_class.constantize.build(
      JSON.parse(section.list_renderer_attributes, symbolize_names: true),
      params
    )
  end

  def show
    @renderer = section.document_renderer_class.constantize.build(
      params[:id],
      JSON.parse(section.document_renderer_attributes, symbolize_names: true),
      params
    )
  end

  def new
    runner = section.new_item_processor_class
                    .constantize
                    .for_new_action(
                      JSON.parse(section.new_item_processor_attributes, symbolize_names: true),
                      params
                    )

    if runner.should_render_form? # TODO: bad decision???
      @runner = runner
    elsif runner.should_redirect?
      redirect_to runner.redirect_path
    else
      head :bad_request
    end
  end

  def create
    runner = section.new_item_processor_class
                    .constantize
                    .for_create_action(
                      JSON.parse(section.new_item_processor_attributes, symbolize_names: true),
                      params
                    )

    unless runner.should_render_form?
      head :bad_request
      return
    end

    if runner.record.save
      redirect_to at_records_path(section_id: section.id)
    else
      @runner = runner
      render :new
    end
  end

  def edit
    unless section.allow_editing?
      head :bad_request
      return
    end

    fail 'Not Implemented'
  end

  def update
    unless section.allow_editing?
      head :bad_request
      return
    end

    fail 'Not Implemented'
  end

  def destroy
    unless section.allow_deleting?
      head :bad_request
      return
    end

    runner = section.new_item_processor_class
                    .constantize
                    .for_destroy_action(
                      JSON.parse(section.new_item_processor_attributes, symbolize_names: true),
                      params
                    )

    runner.record.destroy

    redirect_to at_records_path(section_id: section.id)
  end

  private

  def form_url
    @runner.record.persisted? ? at_record_path(@runner.record) : at_records_path
  end
  helper_method :form_url

  def form_method
    @runner.record.persisted? ? :patch : :post
  end
  helper_method :form_method

  def section
    @section ||= Erp::Section.find(params[:section_id])
  end
  helper_method :section
end

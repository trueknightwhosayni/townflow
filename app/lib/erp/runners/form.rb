module Erp
  module Runners
    class Form < Base
      def self.for_new_action(attributes, params)
        instance = new(attributes[:form_id], params)
        instance.build_record_for_new

        instance
      end

      def self.for_create_action(attributes, params)
        instance = new(attributes[:form_id], params)
        instance.build_record_for_create

        instance
      end

      def self.for_destroy_action(attributes, params)
        new(attributes[:form_id], params)
      end

      def initialize(form_id, params)
        @params = params
        @form = Anything::Form.find(form_id)
      end

      def title
        @form.collection.title
      end

      def should_render_form?
        true
      end

      def should_redirect?
        false
      end

      def redirect_path
        raise 'Not Supporthed for the Form runner'
      end

      def build_record_for_new
        @record ||=
          begin
            r = neewom_form.build_resource
            r.collection = @form.collection

            r
          end
      end

      def build_record_for_create
        @record ||= begin
          r = neewom_form.build_resource permitted_params
          r.collection = @form.collection

          r
        end
      end

      def record
        @record ||= neewom_form.find(@params[:id])
      end

      def neewom_form
        @neewom_form ||= @form.to_neewom_form
      end

      private

      def fetch_record
        @form.collection.god_records.find(params[:id])
      end

      def permitted_params
        @params.require(neewom_form.strong_params_require).permit(neewom_form.strong_params_permit)
      end
    end
  end
end

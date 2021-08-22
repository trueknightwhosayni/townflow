module Erp
  module Renderers
    class List < Base
      def self.build(attributes, params)
        new(attributes[:view_id], params)
      end

      def initialize(view_id, params)
        @params = params
        @view = Anything::View.find(view_id)
      end

      def title
        @view.collection.title
      end

      def fields
        @fields ||= @view.fields
      end

      def records
        @records ||= fetch_records
      end

      private

      def fetch_records
        a = @view.collection.god_records.page(@params[:page] || 1).per(@params[:per_page] || DEFAULT_PER_PAGE)
      end
    end
  end
end

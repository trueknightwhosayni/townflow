module Erp
  module Runners
    class Base
      def should_render_form?
        raise 'Not Implemented'
      end

      def should_redirect?
        raise 'Not Implemented'
      end

      def redirect_path
        raise 'Not Implemented'
      end
    end
  end
end

module Erp
  module Managers
    class NewEntity
      def self.available_processors # TODO i18n here
        [
          ['Form', Erp::Runners::Form],
          ['Process', Erp::Runners::Process]
        ]
      end
    end
  end
end

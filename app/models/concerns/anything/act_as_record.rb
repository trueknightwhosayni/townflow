module Anything::ActAsRecord
  extend ActiveSupport::Concern

  included do
    def relation_label
      raise 'Not Implemented'
    end
  end
end
module GTFS
  module Meta
    class Resource < ActiveRecord::Base
      self.abstract_class = true
      self.table_name_prefix = Config.resource_table_prefix
    end
  end
end

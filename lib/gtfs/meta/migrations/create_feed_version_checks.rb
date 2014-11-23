module GTFS
  module Meta
    class CreateFeedVersionChecks < ActiveRecord::Migration
      TABLE_NAME = Config.resource_table_prefix.concat("feed_version_checks").to_sym

      def change
        create_table TABLE_NAME do |t|
          t.integer :feed_version_id, :null => false
          t.string :status
          t.timestamps
        end

        add_index TABLE_NAME, :feed_version_id
      end
    end
  end
end

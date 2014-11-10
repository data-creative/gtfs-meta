module GTFS
  module Meta
    class CreateFeedVersionChecks < ActiveRecord::Migration
      #TODO: re-construct this migration from a custom generator

      def change
        create_table :feed_version_checks do |t|
          t.integer :feed_version_id, :null => false
          t.string :status
          t.timestamps
        end

        add_index :feed_version_checks, :feed_version_id
      end
    end
  end
end

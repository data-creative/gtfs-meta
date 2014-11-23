module GTFS
  module Meta
    class CreateFeedVersions < ActiveRecord::Migration
      TABLE_NAME = Config.resource_table_prefix.concat("feed_versions").to_sym

      def change
        create_table TABLE_NAME do |t|
          t.integer :feed_id, :null => false
          t.string :etag, :null => false
          t.datetime :last_modified_at, :null => false
          t.text :file_names
          t.timestamps
        end

        add_index TABLE_NAME, :feed_id
        add_index TABLE_NAME, [:feed_id, :etag, :last_modified_at], :unique => true, :name => "version_composite_key"
      end
    end
  end
end

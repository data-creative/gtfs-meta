module GTFS
  module Meta
    class CreateFeedVersions < ActiveRecord::Migration
      #TODO: re-construct this migration from a custom generator

      def change
        create_table :feed_versions do |t|
          t.integer :feed_id, :null => false
          t.string :etag, :null => false
          t.datetime :last_modified_at, :null => false
          t.text :file_names
          t.timestamps
        end

        add_index :feed_versions, :feed_id
        add_index :feed_versions, [:feed_id, :etag, :last_modified_at], :unique => true, :name => "version_composite_key"
      end
    end
  end
end

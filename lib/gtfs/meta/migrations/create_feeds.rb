module GTFS
  module Meta
    class CreateFeeds < ActiveRecord::Migration
      TABLE_NAME = Config.resource_table_prefix.concat("feeds").to_sym

      def change
        create_table TABLE_NAME do |t|
          t.integer :publisher_id, :null => false
          t.string :source_url, :null => false
          t.string :source_title, :null => false
          t.timestamps
        end

        add_index TABLE_NAME, :publisher_id
        add_index TABLE_NAME, :source_url, :unique => true
        add_index TABLE_NAME, [:publisher_id, :source_title], :unique => true, :name => "publisher_unique_source_titles"
      end
    end
  end
end

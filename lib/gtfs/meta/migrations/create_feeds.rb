module GTFS
  module Meta
    class CreateFeeds < ActiveRecord::Migration
      #TODO: re-construct this migration from a custom generator

      def change
        create_table :feeds do |t|
          t.integer :publisher_id, :null => false
          t.string :source_url, :null => false
          t.string :source_title, :null => false
          t.timestamps
        end

        add_index :feeds, :publisher_id
        add_index :feeds, :source_url, :unique => true
        add_index :feeds, [:publisher_id, :source_title], :unique => true, :name => "publisher_unique_source_titles"
      end
    end
  end
end

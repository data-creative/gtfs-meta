module GTFS
  module Meta
    class CreatePublishers < ActiveRecord::Migration
      #TODO: re-construct this migration from a custom generator

      def change
        create_table :publishers do |t|
          t.string :name
          t.string :url, :null => false
          t.string :feeds_url
          t.string :email_address
          t.timestamps
        end
      end
    end
  end
end

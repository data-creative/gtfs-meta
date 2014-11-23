module GTFS
  module Meta
    class CreatePublishers < ActiveRecord::Migration
      def change
        create_table Config.resource_table_prefix.concat("publishers").to_sym do |t|
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

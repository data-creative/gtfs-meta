module GTFS
  module Meta
    class FeedVersion < ActiveRecord::Base
      #TODO: re-construct this model from a custom generator

      belongs_to :feed, :inverse_of => :versions, :class_name => "GTFS::Meta::Feed"

      serialize :file_names, Array

      def destination_path
        "#{GTFS_DATA_DIRECTORY}/publishers/#{feed.source_host_name}/feeds/#{feed.source_title.downcase.gsub("-","").gsub(" ","")}/versions/#{etag}"
      end
    end
  end
end

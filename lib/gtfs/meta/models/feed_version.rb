module GTFS
  module Meta
    class FeedVersion < Resource
      belongs_to :feed, :inverse_of => :versions, :class_name => "GTFS::Meta::Feed"

      serialize :file_names, Array

      def destination_path
        "#{Config.feed_file_management_directory}/publishers/#{feed.source_host_name}/feeds/#{feed.source_title.downcase.gsub("-","").gsub(" ","")}/versions/#{etag}"
      end
    end
  end
end

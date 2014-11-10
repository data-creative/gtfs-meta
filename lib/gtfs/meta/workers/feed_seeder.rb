module GTFS
  module Meta
    class FeedSeeder
      def self.perform(options = {})
        feed_publishers = options[:feed_publishers]
        feeds = options[:feeds]

        GTFS::Meta::Publisher.first_or_create(feed_publishers)
        GTFS::Meta::Feed.first_or_create(feeds)
      end
    end
  end
end

module GTFS
  module Meta
    class FeedSeeder
      def self.perform(options = {})
        publishers = options[:publishers]
        feeds = options[:feeds]

        GTFS::Meta::Publisher.first_or_create(publishers)
        GTFS::Meta::Feed.first_or_create(feeds)
      end
    end
  end
end

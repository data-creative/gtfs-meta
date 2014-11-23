module GTFS
  module Meta
    class FeedSeeder
      def self.perform(options = {})
        publishers = options[:publishers] || Config.feed_publishers
        feeds = options[:feeds] || Config.published_feeds

        CreatePublishers.migrate(:up) unless Resource.connection.table_exists?(Config.resource_table_prefix.concat("publishers"))
        CreateFeeds.migrate(:up) unless Resource.connection.table_exists?(Config.resource_table_prefix.concat("feeds"))
        CreateFeedVersions.migrate(:up) unless Resource.connection.table_exists?(Config.resource_table_prefix.concat("feed_versions"))
        CreateFeedVersionChecks.migrate(:up) unless Resource.connection.table_exists?(Config.resource_table_prefix.concat("feed_version_checks"))

        Publisher.first_or_create(publishers)
        Feed.first_or_create(feeds)
      end
    end
  end
end

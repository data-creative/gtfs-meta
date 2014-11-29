module GTFS
  module Meta
    class DatabaseMigrator
      def self.perform
        #CreatePublishers.migrate(:up) unless Resource.connection.table_exists?(Config.resource_table_prefix.concat("publishers"))
        #CreateFeeds.migrate(:up) unless Resource.connection.table_exists?(Config.resource_table_prefix.concat("feeds"))
        #CreateFeedVersions.migrate(:up) unless Resource.connection.table_exists?(Config.resource_table_prefix.concat("feed_versions"))
        #CreateFeedVersionChecks.migrate(:up) unless Resource.connection.table_exists?(Config.resource_table_prefix.concat("feed_version_checks"))
      end
    end
  end
end
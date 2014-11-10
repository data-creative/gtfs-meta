require "gtfs"

module GTFS
  module Meta
    MESSAGE = "open transit data ftw"
    GTFS_DATA_DIRECTORY = "db/gtfs" #todo: allow configuration
  end
end

require "gtfs/meta/version"

require "gtfs/meta/migrations/create_publishers"
require "gtfs/meta/migrations/create_feeds"
require "gtfs/meta/models/publisher"
require "gtfs/meta/models/feed"
require "gtfs/meta/workers/feed_seeder"

require "gtfs/meta/migrations/create_feed_versions"
require "gtfs/meta/migrations/create_feed_version_checks"
require "gtfs/meta/models/feed_version"
require "gtfs/meta/models/feed_version_check"
require "gtfs/meta/workers/feed_manager"

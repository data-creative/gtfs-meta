require "gtfs"

module GTFS
  module Meta
  end
end

require "gtfs/meta/config"
require "gtfs/meta/resource"
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

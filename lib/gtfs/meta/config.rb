module GTFS
  module Meta
    class Config
      def self.feed_file_management_directory
        "db/gtfs"
      end

      def self.resource_table_prefix
        "gtfs_"
      end

      def self.feed_publishers
        [
          {:id => 1, :name => "Shore Line East", :url => "http://www.shorelineeast.com", :feeds_url => nil},
          {:id => 2, :name => "Metropolitan Transportation Authority", :url => "http://web.mta.info/developers", :feeds_url => "http://web.mta.info/developers/developer-data-terms.html#data"},
          {:id => 3, :name => "CT Transit", :url => "http://www.cttransit.com/", :feeds_url => "http://www.cttransit.com/about/developers/gtfsdata/Main.asp"},
          {:id => 4, :name => "Chicago Transit Authority", :url => "http://www.transitchicago.com/", :feeds_url => "http://www.transitchicago.com/downloads/sch_data/"},
          {:id => 5, :name => "Washington Metro Transit Authority", :url => "http://www.wmata.com/", :feeds_url => "http://www.wmata.com/rider_tools"}
        ]
      end

      def self.published_feeds
        [
          {:publisher_id => 1, :source_url => "http://www.shorelineeast.com/google_transit.zip", :source_title => "Shore Line East"},
          {:publisher_id => 2, :source_url => "http://web.mta.info/developers/data/mnr/google_transit.zip", :source_title => "Metro-North Railroad"},
          {:publisher_id => 2, :source_url => "http://web.mta.info/developers/data/nyct/subway/google_transit.zip", :source_title => "New York City Transit Subway"},
          {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googleha_transit.zip", :source_title => "Hartford"},
          {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googlenh_transit.zip", :source_title => "New Haven"},
          {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googlestam_transit.zip", :source_title => "Stamford"},
          {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googlewat_transit.zip", :source_title => "Waterbury"},
          {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googlenb_transit.zip", :source_title => "New Britain"},
          {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googleme_transit.zip",:source_title => "Meriden"},
          {:publisher_id => 4, :source_url => "http://www.transitchicago.com/downloads/sch_data/google_transit.zip", :source_title => "N/A - Chicago Transit Authority"},
          {:publisher_id => 5, :source_url => "http://www.wmata.com/rider_tools/license_agreement.cfm?google_transit.zip", :source_title => "N/A - WMATA"}
        ]
      end
    end
  end
end

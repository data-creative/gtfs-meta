# GTFS::Meta

A [General Transit Feed Specification (GTFS)](https://developers.google.com/transit/gtfs/) data and metadata manager for ActiveRecord. 

Extracts feed data, manages feed versions, and extends the feed specification to include feed metadata.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gtfs-meta'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gtfs-meta

## Usage

### Migrating the Database

```` rb
GTFS::Meta::CreatePublishers.migrate(:up)
GTFS::Meta::CreateFeeds.migrate(:up)
GTFS::Meta::CreateFeedVersions.migrate(:up)
GTFS::Meta::CreateFeedVersionChecks.migrate(:up)
````

### Feed-Seeding

Pass custom seed data to the [FeedSeeder](lib/gtfs/meta/feed_seeder.rb) to persist valid feeds and feed_publishers to the database. 

```` rb
MY_FEED_PUBLISHERS = [
  {
    :id => 1,
    :name => "Shore Line East",
    :url => "http://www.shorelineeast.com",
    :feeds_url => nil,
    :email_address => nil
  },
  {
    :id => 2,
    :name => "Metropolitan Transportation Authority",
    :url => "http://web.mta.info/developers",
    :feeds_url => "http://web.mta.info/developers/developer-data-terms.html#data",
    :email_address => nil
  },
  {
    :id => 3,
    :name => "CT Transit",
    :url => "http://www.cttransit.com/",
    :feeds_url => "http://www.cttransit.com/about/developers/gtfsdata/Main.asp",
    :email_address => nil
  }
]

MY_FEEDS = [
  {
    :publisher_id => 1,
    :source_url => "http://www.shorelineeast.com/google_transit.zip",
    :source_title => "Shore Line East"
  },
  {
    :publisher_id => 2,
    :source_url => "http://web.mta.info/developers/data/mnr/google_transit.zip",
    :source_title => "Metro-North Railroad",
  },
  {
    :publisher_id => 2,
    :source_url => "http://web.mta.info/developers/data/nyct/subway/google_transit.zip",
    :source_title => "New York City Transit Subway",
  },
  {
    :publisher_id => 3,
    :source_url => "http://www.cttransit.com/uploads_GTFS/googleha_transit.zip",
    :source_title => "Hartford"
  },
  {
    :publisher_id => 3,
    :source_url => "http://www.cttransit.com/uploads_GTFS/googlenh_transit.zip",
    :source_title => "New Haven"
  },
  {
    :publisher_id => 3,
    :source_url => "http://www.cttransit.com/uploads_GTFS/googlestam_transit.zip",
    :source_title => "Stamford"
  },
  {
    :publisher_id => 3,
    :source_url => "http://www.cttransit.com/uploads_GTFS/googlewat_transit.zip",
    :source_title => "Waterbury"
  },
  {
    :publisher_id => 3,
    :source_url => "http://www.cttransit.com/uploads_GTFS/googlenb_transit.zip",
    :source_title => "New Britain"
  },
  {
    :publisher_id => 3,
    :source_url => "http://www.cttransit.com/uploads_GTFS/googleme_transit.zip",
    :source_title => "Meriden"
  }
]

GTFS::Meta::FeedSeeder.perform(:feed_publishers => MY_FEED_PUBLISHERS, :feeds => MY_FEEDS)
````

Consult the [reference documentation](README.md#reference) for guidance on defining attributes for feeds and associated publishers. 

### Feed-Managing

Once persisted, pass one or more feeds to the FeedManager.

```` rb
feeds = GTFS::Meta::Feed.all
GTFS::Meta::FeedManager.perform(:feeds => feeds)
````

## Reference

TODO: Provide high-level summary of GTFS metadata resources

### FeedPublisher (Publisher)

A `FeedPublisher` is a type of [`Agency`](https://developers.google.com/transit/gtfs/reference#agency_fields) that provides authoritative source data for a given `Feed`. A publisher may host one or more feeds.

TODO: Define `FeedPublisher` attributes

### Feed

A `Feed` represents a dedicated source of GTFS data available for download in `.zip` format over `http`. Feeds are published and modified by their respective publishers.

TODO: Define `Feed` attributes

> NOTE: a feed's source attributes (`source_url` and `source_title`) originate from the feed's html link attributes: `<a href="SOURCE_URL">SOURCE_TITLE</a>`.

### FeedVersion

A `FeedVersion` is a collective modification of feed files provided by a feed publisher. New feed versions supercede previous versions, and are effective for a limited period of time.

TODO: Define `FeedVersion` attributes

### FeedFile

A [`FeedFile`](https://developers.google.com/transit/gtfs/reference#FeedFiles) is a physical `.txt` file of GTFS data containing one or more versioned instances of a given [`GTFS::Model`](https://github.com/nerdEd/gtfs/blob/master/lib/gtfs/model.rb). Feed files are released collectively in versions by their respective publisher.

### FeedFileVersion

TODO: Summarize `FeedFileVersion`

TODO: Define `FeedFileVersion` attributes

## Contributing

1. Fork it ( https://github.com/s2t2/gtfs-meta/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

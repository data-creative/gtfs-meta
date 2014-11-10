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

Pass custom seed data to the [FeedSeeder](lib/gtfs/meta/workers/feed_seeder.rb) to persist valid feeds and feed_publishers to the database. 

```` rb
MY_FEED_PUBLISHERS = [
  {:id => 1, :name => "Shore Line East", :url => "http://www.shorelineeast.com", :feeds_url => nil, :email_address => nil},
  {:id => 2, :name => "Metropolitan Transportation Authority", :url => "http://web.mta.info/developers", :feeds_url => "http://web.mta.info/developers/developer-data-terms.html#data", :email_address => nil},
  {:id => 3, :name => "CT Transit", :url => "http://www.cttransit.com/", :feeds_url => "http://www.cttransit.com/about/developers/gtfsdata/Main.asp", :email_address => nil}
]

MY_FEEDS = [
  {:publisher_id => 1, :source_url => "http://www.shorelineeast.com/google_transit.zip", :source_title => "Shore Line East"},
  {:publisher_id => 2, :source_url => "http://web.mta.info/developers/data/mnr/google_transit.zip", :source_title => "Metro-North Railroad"},
  {:publisher_id => 2, :source_url => "http://web.mta.info/developers/data/nyct/subway/google_transit.zip", :source_title => "New York City Transit Subway"},
  {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googleha_transit.zip", :source_title => "Hartford"},
  {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googlenh_transit.zip", :source_title => "New Haven"},
  {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googlestam_transit.zip", :source_title => "Stamford"},
  {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googlewat_transit.zip", :source_title => "Waterbury"},
  {:publisher_id => 3, :source_url => "http://www.cttransit.com/uploads_GTFS/googlenb_transit.zip", :source_title => "New Britain"},
  {:publisher_id => 3,:source_url => "http://www.cttransit.com/uploads_GTFS/googleme_transit.zip",:source_title => "Meriden"}
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

### FeedPublisher (Publisher)

A `FeedPublisher` is a type of [`Agency`](https://developers.google.com/transit/gtfs/reference#agency_fields) that provides authoritative source data for a given `Feed`. A publisher may host one or more feeds.

#### Field Definitions:

todo: define attributes

#### Sample Data:

id	| name	| url	| feeds_url	| email_address	| created_at	| updated_at
--- | --- | --- | --- | --- | --- | ---
1	| Shore Line East	| http://www.shorelineeast.com	| NULL	| NULL	| 2014-11-06 12:42:52	| 2014-11-06 12:42:52
2	| Metropolitan Transportation Authority	| http://web.mta.info/developers	| http://web.mta.info/developers/developer-data-terms.html#data	| NULL	| 2014-11-06 12:42:52	| 2014-11-06 12:42:52
3	| CT Transit	| http://www.cttransit.com/	| http://www.cttransit.com/about/developers/gtfsdata/Main.asp	| NULL	2014-11-06 12:42:52	| 2014-11-06 12:42:52

### Feed

A `Feed` represents a dedicated source of GTFS data available for download in `.zip` format over `http`. Feeds are published and modified by their respective publishers.

#### Field Definitions:

todo: define attributes

#### Sample Data:

id	| publisher_id	| source_url	| source_title	| created_at	| updated_at
--- | --- | --- | --- | --- | --- 
1	| 1	| http://www.shorelineeast.com/google_transit.zip	| Shore Line East	| 2014-11-06 12:42:52	| 2014-11-06 12:42:52
2	| 2	| http://web.mta.info/developers/data/mnr/google_transit.zip	| Metro-North Railroad	| 2014-11-06 12:42:52	| 2014-11-06 12:42:52
3	| 2	| http://web.mta.info/developers/data/nyct/subway/google_transit.zip	| New York City Transit Subway	| 2014-11-06 12:42:52	| 2014-11-06 12:42:52
4	| 3	| http://www.cttransit.com/uploads_GTFS/googleha_transit.zip	| Hartford	| 2014-11-06 12:42:52	| 2014-11-06 12:42:52
5	| 3	| http://www.cttransit.com/uploads_GTFS/googlenh_transit.zip	| New Haven	| 2014-11-06 12:42:52	| 2014-11-06 12:42:52

> NOTE: a feed's source attributes (`source_url` and `source_title`) originate from the feed's html link attributes: `<a href="SOURCE_URL">SOURCE_TITLE</a>`.

### FeedVersion

A `FeedVersion` is a collective modification of feed files provided by a feed publisher. New feed versions supercede previous versions, and are effective for a limited period of time.

#### Field Definitions:

todo: define attributes

#### Sample Data:

id	|	feed_id	|	etag	|	last_modified_at |	file_names	|	created_at	|	updated_at
--- | --- |--- | --- | --- | --- | ---
1	|	1	|	26349c817da114d66c0	|	2014-10-03 13:54:11	|some binary output	|	2014-11-06 12:43:08	|	2014-11-09 18:50:55
2	|	2	|	W683aa544eaa01	|	2014-10-27 20:24:33	|some binary output	|	2014-11-06 12:43:10	|	2014-11-09 18:50:57
3	|	3	|	W4cd511541c8db0	|	2014-09-19 20:10:24	|some binary output	|	2014-11-06 12:43:26	|	2014-11-09 18:51:08
4	|	4	|	329c33d849d4cf1124e	|	2014-09-19 20:39:44	|some binary output	|	2014-11-06 12:43:38	|	2014-11-06 12:46:47
5	|	5	|	d6594392f3c6cf1124e	|	2014-09-02 21:19:25	|some binary output	|	2014-11-06 12:43:47	|	2014-11-06 12:46:56
6	|	6	|	8db438eb8eb8cf1124e	|	2014-08-15 13:43:38	|some binary output	|	2014-11-06 12:43:51	|	2014-11-06 12:46:59
7	|	7	|	28f16c8c481cf1124e	|	2014-06-06 20:20:38	|some binary output	|	2014-11-06 12:43:53	|	2014-11-06 12:47:00
8	|	8	|	faac30c98aadcf1124e	|	2014-08-01 13:16:20	|some binary output	|	2014-11-06 12:43:55	|	2014-11-06 12:47:02
9	|	9	|	b4bd11ecc481cf1124e	|	2014-06-06 20:21:39	|some binary output	|	2014-11-06 12:43:55	|	2014-11-06 12:47:03
10	|	4	|	329c33d849d4cf11254	|	2014-09-19 20:39:44	|some binary output	|	2014-11-08 06:37:38	|	2014-11-09 18:51:22
11	|	5	|	d6594392f3c6cf11254	|	2014-09-02 21:19:25	|some binary output	|	2014-11-08 06:37:50	|	2014-11-09 18:51:31
12	|	6	|	8db438eb8eb8cf11254	|	2014-08-15 13:43:38	|some binary output	|	2014-11-08 06:37:54	|	2014-11-09 18:51:33
13	|	7	|	28f16c8c481cf11254	|	2014-06-06 20:20:38	|some binary output	|	2014-11-08 06:37:56	|	2014-11-09 18:51:36
14	|	8	|	faac30c98aadcf11254	|	2014-08-01 13:16:20	|some binary output	|	2014-11-08 06:37:59	|	2014-11-09 18:51:37
15	|	9	|	b4bd11ecc481cf11254	|	2014-06-06 20:21:39	|some binary output	|	2014-11-08 06:38:00	|	2014-11-09 18:51:38

### FeedVersionCheck

#### Field Definitions:

todo: define attributes

#### Sample Data:

id	| feed_version_id |	status |	created_at	| updated_at
---- | ---- | --- | --- | ---
1	| 1	| SUCCESS	| 2014-11-10 08:58:48	| 2014-11-10 08:58:48
10	| 1	| SUCCESS	| 2014-11-10 09:01:01	| 2014-11-10 09:01:01
11	| 2	| SUCCESS	| 2014-11-10 09:01:02	| 2014-11-10 09:01:02
2	| 2	| SUCCESS	| 2014-11-10 08:58:49	| 2014-11-10 08:58:49
12	| 3	| SUCCESS	| 2014-11-10 09:01:07	| 2014-11-10 09:01:07

### FeedFile

A [`FeedFile`](https://developers.google.com/transit/gtfs/reference#FeedFiles) is a physical `.txt` file of GTFS data containing one or more versioned instances of a given [`GTFS::Model`](https://github.com/nerdEd/gtfs/blob/master/lib/gtfs/model.rb). Feed files are released collectively in versions by their respective publisher.

### FeedFileVersion

todo: summarize 

todo: define attributes

todo: provide sample data

## Contributing

1. Fork it ( https://github.com/databyday/gtfs-meta/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

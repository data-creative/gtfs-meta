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

## Reference

### Publisher

A `Publisher` is a type of [`Agency`](https://developers.google.com/transit/gtfs/reference#agency_fields) that provides authoritative source data for a given `Feed`. A publisher may host one or more feeds.

### Feed

A `Feed` represents a dedicated source of GTFS data available for download in `.zip` format over `http`. Feeds are published and modified by their respective publishers.

> NOTE: a feed's source attributes (`source_url` and `source_title`) originate from the feed's html link attributes: `<a href="SOURCE_URL">SOURCE_TITLE</a>`.

### FeedVersion

A `FeedVersion` is a collective modification of feed files provided by a feed publisher. New feed versions supercede previous versions, and are effective for a limited period of time.

### FeedFile

A [`FeedFile`](https://developers.google.com/transit/gtfs/reference#FeedFiles) is a physical `.txt` file of GTFS data containing one or more versioned instances of a given [`GTFS::Model`](https://github.com/nerdEd/gtfs/blob/master/lib/gtfs/model.rb). Feed files are released collectively in versions by their respective publisher.

## Usage

...

## Contributing

1. Fork it ( https://github.com/databyday/gtfs-meta/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

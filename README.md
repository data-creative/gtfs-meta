# GTFS::Meta

A [General Transit Feed Specification (GTFS)](https://developers.google.com/transit/gtfs/) data and metadata manager for ActiveRecord. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gtfs-meta'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gtfs-meta

## Configuration

Reference the following list of configurable options.

name | description | optionality | default value
--- | --- | --- | ---
feed_file_management_directory | path to local directory where feed files will be stored and managed | optional | "db/gtfs"
resource_table_prefix | database table schema prefix for gtfs meta resources | optional | "gtfs_"
feed_source_urls | gtfs feed sources for consumption  | **required** | N/A

To speficy values for one or more configuration option, add the following block of code to your project:

```` rb
GTFS::Meta.configure do |config|
  config.feed_source_urls = [
    "http://some_host.com/some_gtfs_file_name.zip",
    "http://some_host.com/another_gtfs_file_name.zip",
    "http://different_host.info/developer_page/a_gtfs_file.zip"
  ]
  config.feed_file_management_directory = "some/local/path" # optional
  config.feed_file_management_directory = "some/local/path" # optional
end
````

> Tip: For Ruby on Rails projects, place this code in a new file called *config/initializers/gtfs_meta.rb*.

## Usage

1. Migrate the database.
```` rb
GTFS::Meta::DatabaseMigrator.perform
````

2. Seed configured feed sources.
```` rb
GTFS::Meta::FeedSeeder.perform
````

3. Manage data and metadata from configured feed sources.
```` rb
GTFS::Meta::FeedManager.perform
````

> Tip: Schedule execution of the feed manager via cron to periodically check for feed updates and get the latest versions.

## Contributing

1. Fork it ( https://github.com/databyday/gtfs-meta/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

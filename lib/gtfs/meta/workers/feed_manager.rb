require 'net/http'
require 'uri'
require 'zip'
#require 'gtfs'

module GTFS
  module Meta
    class FeedManager
      #FEED_FILE_NAMES = GTFS::Source::ENTITIES.map{|e| e.name == "Agency" ? e.singular_name.to_s.concat(".txt") : e.name.to_s.concat(".txt")}
      FEED_FILE_NAMES = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendars.txt", "calendar_dates.txt", "shapes.txt", "fare_attributes.txt", "fare_rules.txt", "frequencies.txt", "transfers.txt"]

      def self.perform(options = {})
        feeds = options[:feeds]

        feeds.find_each do |feed|
          begin
            # CHECK VERSION

            uri = URI.parse(feed.source_url)
            response = Net::HTTP.get_response(uri)
            etag = response.to_hash["etag"].first.gsub!(/[^0-9A-Za-z]/, '')
            last_modified_at = response.to_hash["last-modified"].first.try(:to_datetime)

            raise EtagError.new(etag) unless etag.is_a?(String)
            raise LastModifiedError.new(last_modified_at) unless last_modified_at.is_a?(DateTime)
            feed_version = FeedVersion.where({
              :feed_id => feed.id,
              :etag => etag,
              :last_modified_at => last_modified_at
            }).first_or_create
            feed_version_check = FeedVersionCheck.create({
              :feed_version_id => feed_version.id,
              :status => "IN PROGRESS"
            })

            # MANAGE FILES

            FileUtils.mkdir_p(feed_version.destination_path)

            zip_destination_path = "#{feed_version.destination_path}/#{feed.source_file_name}"
            unless File.exist?(zip_destination_path)
              File.open(zip_destination_path, "wb") do |zip_file|
                zip_file.write response.body
              end
              raise SourceExtractionError.new(zip_destination_path) unless File.exist?(zip_destination_path)
            end

            Zip::File.open(zip_destination_path) do |zip_file|
              zip_file.each do |entry|
                begin
                  entry_name = entry.name
                  raise InvalidEntryName.new(entry_name) unless FEED_FILE_NAMES.include?(entry_name)
                  feed_version.file_names << entry_name unless feed_version.file_names.include?(entry_name)

                  feed_file_path = "#{feed_version.destination_path}/#{entry_name}"
                  raise FeedFileExists.new(feed_file_path) if File.exist?(feed_file_path)

                  entry.extract(feed_file_path)
                  raise FeedFileExtractionError.new(feed_file_path) unless File.exist?(feed_file_path)
                rescue InvalidEntryName => e
                  next
                rescue FeedFileExists => e
                  next
                end
              end
            end

            FileUtils.rm(zip_destination_path)
            raise SourceRemovalError.new(zip_destination_path) if File.exist?(zip_destination_path)

            feed_version.save!
            feed_version_check.update_attributes(:status => "SUCCESS")
          rescue => e
            puts "#{e.class} -- #{e.message}"
            feed_version_check.update_attributes(:status => "FAILURE") if feed_version_check
          end
        end
      end

      class EtagError < StandardError
      end

      class LastModifiedError < StandardError
      end

      class SourceExtractionError < StandardError
      end

      class InvalidEntryName < StandardError
      end

      class FeedFileExists < StandardError
      end

      class FeedFileExtractionError < StandardError
      end

      class SourceRemovalError < StandardError
      end
    end
  end
end

require 'uri'

module GTFS
  module Meta
    class Feed < ActiveRecord::Base
      #TODO: re-construct this model from a custom generator

      belongs_to :publisher, :inverse_of => :feeds, :class_name => "GTFS::Meta::Publisher"

      has_many :versions, :inverse_of => :feed, :class_name => "GTFS::Meta::FeedVersion"

      validate :source_zipness_validator

      def source_zipness_validator
        errors.add(:source_url, "is not a zip") unless (source_url && source_file_name.ends_with?(".zip"))
      end

      def source_host_name
        URI(source_url).hostname.split(".").reverse[1]
      end

      def source_file_name
        source_url.split("/").last
      end
    end
  end
end

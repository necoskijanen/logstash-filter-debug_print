# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "json"

class LogStash::Filters::DebugPrinter < LogStash::Filters::Base
  config_name "debug_print"

  # Add a tag to identify the output source
  config :tag, :validate => :string, :default => nil

  # Enable pretty printing of JSON output
  config :pretty, :validate => :boolean, :default => false

  public
  def register
    # Initialization code (if needed)
  end

  public
  def filter(event)
    begin
      # Get the entire event data
      event_data = event.to_hash

      # Build the output content
      output = if @tag
                 { "tag" => @tag, "data" => event_data }
               else
                 { "data" => event_data }
               end

      # Generate JSON output based on pretty print setting
      json_output = @pretty ? 
        JSON.pretty_generate(output) : 
        JSON.generate(output)

      # Write to standard output
      puts json_output

    rescue JSON::GeneratorError => e
      logger.error("JSON generation error", :error => e.message)
    rescue => e
      logger.error("Unexpected error", :error => e.backtrace)
    end

    # Mark as filter matched
    filter_matched(event)
  end
end

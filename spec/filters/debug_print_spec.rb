# encoding: utf-8
require 'spec_helper'
require "logstash/filters/debug_print"

describe LogStash::Filters::DebugPrinter do
  describe "Print event data with default settings" do
    let(:config) do <<-CONFIG
      filter {
        debug_print { }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect { subject.filter(event) }.to output(/"message":"some text"/).to_stdout
    end
  end

  describe "Print event data with a tag" do
    let(:config) do <<-CONFIG
      filter {
        debug_print {
          tag => "test_tag"
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect { subject.filter(event) }.to output(/"tag":"test_tag"/).to_stdout
      expect { subject.filter(event) }.to output(/"message":"some text"/).to_stdout
    end
  end

  describe "Print event data with pretty print enabled" do
    let(:config) do <<-CONFIG
      filter {
        debug_print {
          pretty => true
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect { subject.filter(event) }.to output(/"message": "some text"/).to_stdout
    end
  end
end

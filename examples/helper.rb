require "ostruct"

require "bundler"
Bundler.require

require "prawn/measurement_extensions"

Prawn.debug = true

class Text
  def self.unwrap(text)
    text.split("\n\n").map { |e| e.gsub(/\n/, " ") }.join("\n\n")
  end
end

module Prawn
  module DSL
    def document
      @document ||= Prawn::Document.new
    end

    def method_missing(m, *a, &b)
      document.send(m, *a, &b)
    end

    def update(&b)
      instance_eval(&b)
    end

    def save_as(filename)
      document.render_file(filename)
    end
  end
end

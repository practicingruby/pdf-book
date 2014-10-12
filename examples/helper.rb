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

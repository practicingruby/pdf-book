require "bundler"
Bundler.require

require "prawn/measurement_extensions"

Prawn.debug = true

class DocumentBuilder
  def initialize
    @document = Prawn::Document.new
  end

  def method_missing(m, *a, &b)
    @document.send(m, *a, &b)

    self
  end

  def update(&b)
    @document.instance_eval(&b)
  end

  def save_as(filename)
    @document.render_file(filename)
  end
end

require "bundler"
Bundler.require

require "prawn/measurement_extensions"

Prawn.debug = true

class FormLetter
  def initialize(document, params, styles)
    @document = document
    @params   = params
    @styles   = styles
  end


  def text(content_key)
    @document.text(CGI.unescapeHTML(@params[content_key]),
                   @styles.fetch(content_key, {}))
  end

  def text_group(fragments, style_key=nil)
    @document.formatted_text(
      fragments.map { |e| fragment(e) },
      @styles.fetch(style_key, {}))
  end

  private

  def fragment(content_key)
    { :text => CGI.unescapeHTML(@params[content_key]) }
    .merge(@styles.fetch(content_key, {}))
  end
end

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

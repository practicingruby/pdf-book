require_relative "../helper"

class FormLetter
  include Prawn::View
   
  def initialize(data, styles)
    @data   = data
    @styles   = styles
  end

  def text_snippet(content_key)
    text(@data.send(content_key).strip + "\n",
         @styles.fetch(content_key, {}))
  end

  def text_snippet_group(fragments, style_key=nil)
    formatted_text(
      fragments.map { |e| fragment(e) },
      @styles.fetch(style_key, {}))
  end

  def header_box(position)
    float do
      span(bounds.width / 3.0, :position => position) { yield }
    end
  end

  def body
    span(6.5.in, :position => :center) { yield }
  end

  private

  def fragment(content_key)
    { :text => @data.send(content_key).strip + "\n" }
    .merge(@styles.fetch(content_key, {}))
  end
end

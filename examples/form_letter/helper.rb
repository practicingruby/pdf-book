require_relative "../helper"

class FormLetter
  include Prawn::View
   
  def initialize(params, styles)
    @params   = params
    @styles   = styles
  end

  def text(content_key)
    document.text(@params[content_key].strip + "\n",
                  @styles.fetch(content_key, {}))
  end

  def text_group(fragments, style_key=nil)
    document.formatted_text(
      fragments.map { |e| fragment(e) },
      @styles.fetch(style_key, {}))
  end

  def header_box(position)
    float do
      span(bounds.width / 3.0, :position => position) do
        yield
      end
    end
  end

  def body
    span(6.5.in, :position => :center) { yield }
  end

  private

  def fragment(content_key)
    { :text => @params[content_key].strip + "\n" }
    .merge(@styles.fetch(content_key, {}))
  end
end

class FormLetter::Parser
  def initialize
    @rewrites = {}
  end

  def rewrite(*patterns, &block)
    return rewrite_dynamic(patterns.first, &block) if block

    patterns.each do |pattern|
      key = ":#{pattern}:"

      @rewrites[key] = ->(e) { e[pattern.to_s] }
    end
  end

  def parse(text)
    params = OpenStruct.new

    section         = nil

    text.lines.each do |e| 
      if e[/^::(.*)/, 1]
        section = $1
      elsif section
        @rewrites.select { |k,v| e.include?(k) }
                 .each   { |k,v| e.gsub!(k, v.call(params).strip) }

        (params[section] ||= "") << e
      else
        warn "Section not set!"
      end
    end

    params
  end

  private

  def rewrite_dynamic(pattern, &block)
    key = ":#{pattern}:"

    @rewrites[key] = block
  end
end

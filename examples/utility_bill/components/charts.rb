require_relative "../helper"

Prawn::Component.define(:charts) do
  indent(bounds.width*0.1, bounds.width*0.1) do
    image params[:delivery_chart],   :height => bounds.height / 2
    image params[:generation_chart], :height => bounds.height / 2
  end

  # FIXME: We should find a way to prevent the need for explicit mask here.
  # Also eliminate duplication between this and messages
  mask(:stroke_color) do
    stroke_color "999999"
    stroke_bounds
  end
end

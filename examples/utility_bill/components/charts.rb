require_relative "../helper"

module UtilityBill
  class Charts
    include Prawn::Component

    def draw
      indent(bounds.width*0.05, bounds.width*0.05) do
        image params[:delivery_chart],   :width => bounds.width
        image params[:generation_chart], :width => bounds.width
      end

      # FIXME: We should find a way to prevent the need for explicit mask here.
      mask(:stroke_color) do
        stroke_color "999999"
        stroke_bounds
      end
    end
  end
end

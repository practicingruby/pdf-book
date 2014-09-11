require_relative "helper"
class Flyer
  include Prawn::View

  def initialize
    # NOTE: This is a little clumsy because the Official API
    # recommends defining the document() method. But it's
    # definitely more concise. Should we encourage this practice?
    @document = Prawn::Document.new(:margin => 0)

    define_grid(:columns => 8, :rows => 10)
  end

  def draw_products(products)
    products.each do |name, *coords|
      grid(*coords).bounding_box do
        # FIXME: ASPECT RATIO!
        # Should only need a couple types, 
        # like square and 2x1 rectangle
        float do
          image "images/#{name}.jpg",
            :width => bounds.width, :height => bounds.height
        end

        transparent(0.5) do
          fill_rectangle bounds.top_left, bounds.width, 24
        end


        mask(:fill_color, :line_width) do
          fill_color "ffffff"
          line_width 0.5

          move_down(5)

          text_rendering_mode(:fill_stroke) do
            text name.upcase, :size => 16, :align => :center

            move_cursor_to bounds.bottom + 30
            
            indent(0, 10) do
              text "$1.99/lb", :size => 24, :align => :right
            end

          end
        end

        mask(:line_width, :stroke_color) do
          stroke_color "333333"
          line_width 2
          stroke_bounds
        end

      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  flyer = Flyer.new

  flyer.update do
    # TODO: Do we need a higher level API than this?
    
    draw_products [["napa", [0,0], [1,3]],
                   ["avocados", [2,0], [3,3]],
                   ["potatos",  [0,4], [3,7]],
                   ["garlic",   [4,0], [5,1]],
                   ["bittermelon",[4,2], [5,3]],
                   ["kiwi", [4,4], [5,5]],
                   ["limes",[4,6], [5,7]],
                   ["eggplant", [6,0], [6,1]],
                   ["peaches", [6,2], [6,3]],
                   ["plantains", [6,4], [6,5]],
                   ["onions", [6,6], [6,7]],
                   ["chilis", [7,0], [7,1]],
                   ["bellpepper", [7,2], [7,3]],
                   ["mushrooms", [7,4], [7,5]],
                   ["shallots", [7,6], [7,7]],
                   ["blueberries", [8,0], [9,3]],
                   ["apples", [8,4], [9,7]]]
  end

  flyer.save_as("flyer.pdf")
end

`open -a Preview -g flyer.pdf`

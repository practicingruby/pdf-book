require_relative "helper"
class Flyer
  include Prawn::View

  def initialize
    # NOTE: This is a little clumsy because the Official API
    # recommends defining the document() method. But it's
    # definitely more concise. Should we encourage this practice?
    @document = Prawn::Document.new(:margin => 20, 
      :page_size => [12.75.in, 19.8.in])

    define_grid(:columns => 8, :rows => 12, :gutter => 15)
  end

  def draw_products(products)
    grid([0,0],[1,7]).bounding_box do
      line_width 4
      stroke_bounds
      fill_color "ffff00"
      fill_rectangle bounds.top_left, bounds.width, bounds.height
      fill_color "000000"
      text "<b>EEEERVRYBODY's Market</b>\n"+
           "<font size='24'>A place where EEEERVRYBODY is welcome</font>", 
        :align => :center, :size => 50, :leading => 15,
        :valign => :center, :inline_format => true

    end

    products.each do |name, *coords|
      grid(*coords).bounding_box do
        # FIXME: ASPECT RATIO!
        # Should only need a couple types, 
        # like square and 2x1 rectangle
        float do
          image "images/#{name}.jpg",
            :width => bounds.width, :height => bounds.height
        end

        mask(:fill_color) do
          fill_color "ffffff"
          transparent(0.7) do
            fill_rectangle bounds.top_left, bounds.width, 24
          end
        end


        mask(:fill_color, :line_width) do
          fill_color "ffffff"
          line_width 0.5

          move_down(5)

          text name.upcase, :size => 18, :align => :center, :color => "000000"

          text_rendering_mode(:fill_stroke) do

            move_cursor_to bounds.bottom + 30
            
            indent(0, 10) do
              text "$1.99/lb", :size => 32, :align => :right, :style => :bold
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
    
    draw_products [["napa", [2,0], [3,3]],
                   ["avocados", [4,0], [5,3]],
                   ["potatos",  [2,4], [5,7]],
                   ["garlic",   [6,0], [7,1]],
                   ["bittermelon",[6,2], [7,3]],
                   ["kiwi", [6,4], [7,5]],
                   ["limes",[6,6], [7,7]],
                   ["eggplant", [8,0], [8,1]],
                   ["peaches", [8,2], [8,3]],
                   ["plantains", [8,4], [8,5]],
                   ["onions", [8,6], [8,7]],
                   ["chilis", [9,0], [9,1]],
                   ["bellpepper", [9,2], [9,3]],
                   ["mushrooms", [9,4], [9,5]],
                   ["shallots", [9,6], [9,7]],
                   ["blueberries", [10,0], [11,3]],
                   ["apples", [10,4], [11,7]]]
  end

  flyer.save_as("flyer.pdf")
end

`open -a Preview -g flyer.pdf`

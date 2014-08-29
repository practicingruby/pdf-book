require_relative "helper"

if __FILE__ == $PROGRAM_NAME
  Prawn::Document.generate("flyer.pdf", :margin => 0) do
    define_grid(:columns => 8, :rows => 10)
    
    grid([0,0], [1,3]).show
    grid([2,0], [3,3]).show

    grid([0,4], [3,7]).show

    grid([4,0], [5,1]).show
    grid([4,2], [5,3]).show
    grid([4,4], [5,5]).show
    grid([4,6], [5,7]).show

    grid([6,0], [6,1]).show
    grid([6,2], [6,3]).show
    grid([6,4], [6,5]).show
    grid([6,6], [6,7]).show
    
    grid([7,0], [7,1]).show
    grid([7,2], [7,3]).show
    grid([7,4], [7,5]).show
    grid([7,6], [7,7]).show

    grid([8,0], [9,3]).show
    grid([8,4], [9,7]).show
  end
end

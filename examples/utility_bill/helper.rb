require_relative "../helper"

module Prawn
  module Component
    module DocumentExtensions
      def draw(component, box, params={})
        top, left, width, height = box

        top  = top >= 0 ? bounds.top - top : top*-1
        left = left >= 0 ? left : bounds.right - left*-1


        bounding_box([left, top], :width => width, :height => height) do
          component.new(self, params).draw
        end
      end
    end

    include Prawn::View

    attr_reader :document, :params

    def initialize(document, params={})
      @document = document
      @params   = params
    end
  end
end

Prawn::Document.extensions << Prawn::Component::DocumentExtensions

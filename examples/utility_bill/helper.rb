require_relative "../helper"

module Prawn
  module Component
    module DocumentExtensions
      def draw(component, params={})
        component.new(self, params).draw
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

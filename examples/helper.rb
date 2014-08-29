require "ostruct"

require "bundler"
Bundler.require

require "prawn/measurement_extensions"

Prawn.debug = true

class Text
  def self.unwrap(text)
    text.split("\n\n").map { |e| e.gsub(/\n/, " ") }.join("\n\n")
  end
end

module Prawn
  module Component
    def self.definitions
      @definitions ||= {}
    end

    def self.define(name, component_class=nil,&block)
      if component_class
        definitions[name] =component_class
      else
        definitions[name] = Class.new
        definitions[name].send(:include, Prawn::Component)
        definitions[name].send(:define_method, :draw, &block)
      end
    end

    module DocumentExtensions
      def data_source(name)
        define_singleton_method(name) do
          @data_source ||= {}
          @data_source[name] ||= yield
        end
      end

      # consider adding support for padding
      # and if we ever allow dynamic rendering, margins
      def draw(component, params={})
        if Symbol === component
          component = Prawn::Component.definitions[component]
        end

        box = params.delete(:box)
        border = params.delete(:border)

        if box.nil?
          component.new(self, params).draw
          stroke_bounds if border
        else
          left, top, width, height = box

          top  = top >= 0 ? bounds.top - top : top*-1
          left = left >= 0 ? left : bounds.right - left*-1

          bounding_box([left, top], :width => width, :height => height) do
            bounds.define_singleton_method(:move_past_bottom) do
              raise Prawn::Errors::CannotFit
            end

            component.new(self, params).draw
          stroke_bounds if border
          end
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

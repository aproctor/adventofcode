require_relative 'point'

module Ruby
  module Pathfinding

    # This class represents the environment of the
    # area we will be doing pathfinding for.
    # It also holds collision information for the environment.
    # Note, the environment must be rectanglular.
    #
    class Ruby::Pathfinding::SearchArea

      def initialize( lenX, lenY )

        @area_array = Array.new(lenY,0)
        for i in 0..lenY-1
          @area_array[i] = Array.new(lenX,0)
        end

      end

      # Registers a collision within the SearchArea
      def put_collision( x, y )
        @area_array[y][x] = 1
      end

      # Determines if there is a collision at a certain point within the SearchArea
      def collision_at?( x, y )
        return @area_array[y][x] == 1
      end

      # Determines if there is a collision at a certain point within the SearchArea
      def collision_at_p?( p )
        return collision_at?( p.x, p.y )
      end

      # Prints a map of the SearchArea, in the output console.
      def p_arr
        @area_array.each_with_index { |item, i| p "#{i}: #{item}"}
      end

      attr_reader :area_array
    end

  end
end

require_relative 'point'

module Ruby
  module Pathfinding

    # This class represents a point that may also have
    # a "parent' point. This is a very important concept
    # used in the a* pathfinding algorithm.
    class ParentedPoint < Point

      def initialize(x, y, parent)
        @x = x
        @y = y
        @parent = parent;
      end

      # Calculates the g-score from this point to it's parent point.
      def g_curr

        dif_x, dif_y = (@x - @parent.x).abs, (@y - @parent.y).abs
        dif_total = dif_x + dif_y

        if dif_total == 1
          return 10
        else
          return 14
        end

      end

      # Calculates the g-score form this point to the root point.
      def g

        g_score = 0
        curr = self
        until curr.parent == nil
          g_score += curr.g_curr
          curr = curr.parent
        end
        return g_score

      end

      # Calculates the heuristic from this point, to a destination point.
      def h(destination)
        dif_x, dif_y = (@x - destination.x).abs, (@y - destination.y).abs
        return (dif_x + dif_y) * 10
      end

      # Calculates the f-score for this point, to a destination point.
      def f(destination)
        return g + h(destination)
      end

      attr_reader :parent

    end

  end
end
require "ruby/pathfinding/version"
require "ruby/pathfinding/path_finder"
require "ruby/pathfinding/search_area"

module Ruby
  module Pathfinding

    class Tests

      def test1
        #configure search area
        sa = Ruby::Pathfinding::SearchArea.new(10,10)
        start_loc = Ruby::Pathfinding::Point.new(0,0)
        destination = Ruby::Pathfinding::Point.new(9,9)
        0.upto(8) { |x| sa.put_collision x,1 }
        1.upto(9) { |x| sa.put_collision x,8 }

        pf = Ruby::Pathfinding::PathFinder.new(sa,start_loc,destination)
        pf.p_search_area
        puts ''
        pf.find_path
        pf.p_search_area
      end

    end

  end
end

# run the test
Ruby::Pathfinding::Tests.new.test1
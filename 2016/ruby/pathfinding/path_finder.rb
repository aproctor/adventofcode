require_relative 'point'
require_relative 'search_area'
require_relative 'parented_point'


module Ruby
  module Pathfinding

    # This class is the real meat-and-bones of the pathfinding algorithm.
    # It holds information about the environment itself, the parameters of
    # the start, and destination points, and performs the pathfinding algorithm,
    # along with helper functions.
    class PathFinder

      def initialize( sa, start_loc, destination )
        @sa, @start_loc, @destination = sa, start_loc, destination
        @path = nil
      end

      # Attempts to find a path.
      #
      # Note, this method does not have a return value itself,
      # but instead will store the path within the @path variable
      def find_path

        #Add start point to "open" list
        open = Array.new
        closed = Array.new
        parented_start = ParentedPoint.new(@start_loc.x, @start_loc.y, nil)
        open.push(parented_start)

        #Add squares adjacent to starting point to open list
        adj = get_adjacent_tiles(parented_start)
        adj.each {|element| open.push(element)}
        #adj.each {|a| p "Found adjacent at: #{a.x}, #{a.y} , g=#{a.g},h=#{a.h(@destination)},f=#{a.f(@destination)}"}

        #delete starting point from open list
        open.delete(parented_start)
        closed.push(parented_start)
        ##open.each {|curr| puts "have #{curr.x}, #{curr.y} f=#{curr.f(@destination)}"}

        path = nil
        until open.empty?
          #find lowest "f" score on open list, add it to closed list, remove it from open list
          low_f = lowest_f(open, @destination)
          ##puts "at #{low_f.x}, #{low_f.y} f=#{low_f.f(destination)}"
          if low_f.x == @destination.x && low_f.y == @destination.y
            path = Array.new
            path_curr = low_f
            until path_curr == nil
              path.push Point.new(path_curr.x,path_curr.y)
              path_curr = path_curr.parent
            end
            path.reverse!
            ##path.each {|p_c| print "#{p_c.x},#{p_c.y} "}
            #puts ''
            break;
          end
          closed.push( low_f )
          open.delete( low_f )

          #Add tiles adjacent to "low_f" to open list
          adj = get_adjacent_tiles(low_f)
          adj.each do |curr|
            #ignore if on the "closed list"
            on_closed = false
            closed.each do |c_obj|
              if curr.x == c_obj.x && curr.y == c_obj.y
                on_closed = true
                break
              end
            end
            if on_closed
              next
            end
            #check if tile is in "open" list already
            open_obj = nil
            open.each do |o_obj|
              if curr.x == o_obj.x && curr.y == o_obj.y
                open_obj = o_obj
                break
              end
            end
            #if current is already in "open" list, check "g" scores
            if open_obj != nil
              ##puts "#{curr.x}, #{curr.y} is already in open list!"
              #if current "g" score is less then "g" score of object in open list, replace object in open list
              if curr.g < open_obj.g
                open.delete(open_obj)
                open.push(curr)
              else
                ##puts "open path better for #{curr.x}, #{curr.y}"
              end
            else
              #if not in "open" list, add to open list
              open.push(curr)
              ##puts "  add #{curr.x}, #{curr.y} f=#{curr.f(@destination)}"
            end
          end

        end

        @path = path

      end

      # Prints a human-readable version of the environment,
      # and any existing path that is found
      def p_search_area

        @sa.area_array.each_with_index do |item, y|
          print "#{y}: ["
          item.each_with_index do |i2, x|
            if x == @start_loc.x && y == @start_loc.y
              print 'S',' ,'
            elsif x == @destination.x && y == @destination.y
              print 'E',' ,'
            else
              on_path = false
              if path != nil
                @path.each do |p_obj|
                  if x == p_obj.x && y == p_obj.y
                    on_path = true
                    break
                  end
                end
              end

              if on_path
                print '*, '
              else
                print b_to_i(@sa.collision_at?(x,y)),', '
              end

            end
          end
          puts ']'
        end

      end

      attr_reader :sa, :start_loc, :destination, :path

      private
      # bool to integer. 1 if true, 0 if not true.
      def b_to_i(val)
        if val
          return 1
        else
          return 0
        end
      end

      # Gets tiles within the environment that are adjacent to a
      # certain point. Excludes points that are not within the bounds
      # of the environment, and points that have collisions, or diagonal
      # collisions.
      def get_adjacent_tiles( p )
        if p == nil
          puts 'get_adjacent_tiles: Test Point is nil!'
          return Array.new
        end
        ret = Array.new
        -1.upto(1) do |y|
          -1.upto(1) do |x|

            #ignore 0,0, that is the current point
            if x == 0 && y == 0
              next
            end

            #Make sure we are in bounds of search area
            ty, tx = p.y + y, p.x + x
            if ty < 0 ||  tx < 0 || ty >= @sa.area_array.length || tx >= @sa.area_array[0].length
              next
            end

            #make sure there is no collisions here
            if not @sa.collision_at?(tx,ty)
              ##watch the behavior of this, it may be incorrect
              if not diagonal_collision?(p.x,p.y,tx,ty)
                ret.push(ParentedPoint.new(tx,ty,p))
              end
            end

          end
        end
        return ret

      end

      # Determines if there is a collision in the direction
      # of travel, on one of the corners in the direction of travel.
      def diagonal_collision?( from_x, from_y, to_x, to_y )
        if from_x == to_x + 1 && from_y == to_y + 1
          return collision_cb?(from_x,from_y-1) || collision_cb?(from_x-1,from_y)
        elsif from_x == to_x - 1 && from_y == to_y + 1
          return collision_cb?(from_x,from_y-1) || collision_cb?(from_x+1,from_y)
        elsif from_x == to_x - 1 && from_y == to_y - 1
          return collision_cb?(from_x,from_y+1) || collision_cb?(from_x+1,from_y)
        elsif from_x == to_x + 1 && from_y == to_y - 1
          return collision_cb?(from_x, from_y+1) || collision_cb?(from_x-1,from_y)
        end
      end

      # Checks bounds of a point, and determines if there is a collision
      # at that point.
      def collision_cb?( x, y )
        if x < 0 || y < 0 || y >= @sa.area_array.length || x >= @sa.area_array[0].length
          return true
        end
        return @sa.collision_at?(x,y)
      end

      # Finds the point with the lowest f-score that is within the
      # open list.
      def lowest_f( open, destination )

        low, low_f = nil, -1
        open.each do |curr|
          curr_f = curr.f(destination)
          if low == nil
            low = curr
            low_f = curr_f
          elsif curr_f < low_f
            low = curr
            low_f = curr_f
          end
        end

        return low

      end

    end

  end
end
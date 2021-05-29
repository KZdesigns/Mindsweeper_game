class Tile
    Combos = [
        [-1, -1],
        [-1,  0],
        [-1,  1],
        [0,  -1],
        [0,   1],
        [1,  -1],
        [1,   0],
        [1,   1]
    ].freeze #=> used for finding neighboring tiles #freeze is used to ensure this constant is not modified


    attr_reader :pos # => giving read only access to the @position

    def initialize(board, pos) #=> initializing new tile object
        @board, @pos = board, pos #=> creating board and position instance variables
        @bombed, @explored, @flagged = false, false, false #=> creating @bombed, @explored, @flagged for tracking the various options or states of a tile can be
    end

    def bombed?
        @bombed #=> getter method gives access to boolean value
    end

    def explored?
        @explored #=> getter method gives access to boolean value
    end

    def flagged?
        @flagged #=> getter method gives access to boolean value
    end

  
    def neighbors # => returns the neightbors of the given tile 
        adjacent_coords = [] #=> getting all adjacent_coords
        Combos.each do |row, col| #=> loop used to create all adjacent cords
            new_row = pos[0] + row
            new_col = pos[1] + col
            adjacent_coords << [new_row, new_col]
        end
        valid_coords = adjacent_coords.select do |row, col| #=> loop used to only select valid cords
            [row, col].all? do |cord|
                cord.between?(0, @board.grid_size - 1) #=> for testing @board.grid_size => @board.length
            end
        end

        valid_coords.map { |pos| @board[pos] } #=> for testing @board[pos] => |row, col| @board[row][col]
    end #=> returns the neighboring tiles 

  
end




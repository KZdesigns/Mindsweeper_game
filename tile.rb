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

    def adjacent_bomb_count #=> counts the number of bomb tiles adjacent
        self.neighbors.select(&:bombed?).count
    end

    def plant_bomb #=> flips @bombed boolean to true
        @bombed = true
    end

    def toggle_flag #=> flips boolean for flagged unless the tile is already explored
        @flagged = !@flagged unless @explored
    end

    def explore #=> recursion!! 
        # do not explore a location if the tile is flagged
        return self if flagged?

        # do not explore tiles that have already been explored
        return self if explored?

        #=> ^^ base case for recursion method

        # flipping boolean for explored variable to true
        @explored = true 

        if !bombed? && adjacent_bomb_count == 0
            neighbors.each(&:explore) 
        end #=> if the tile is not a bomb and the adjacent bomb count is 0
        #=> loop over each of the neighbors and call explore setting the tile 
        #=> @explored variable to TRUE marking it as explored!

        self #=> return the tile

        #=> ^^ recursive case for recusion method!! 
    end

    def inspect #=> Limits the information when inspecting the Tile this way we dont load the board each time
    {   pos: pos, 
        bombed: bombed?,
        flagged: flagged?,
        explored: explored? }.inspect
    end #=> creating a hash with key value pairs for the instance variables

    def render #=> rendering tiles 
        if flagged?
            "F" #=> if the flagged == true show "F" for the tile
        elsif explored? #=> if explored? == true and adjacent_bomb_count == 0 show "_" otherwise show the count
            adjacent_bomb_count == ? "_" : adjacent_bomb_count.to_s
        else #=> if its not flagged? or explored? show "*"
            "*"
        end
    end

    def reveal #=> used to fully reveal the baord at the end of the game
        if flagged? #=> if the tile was flagged and the tile and bombed? == true return "F" found a bomb otherwise "f" was not a bomb
            bombed? ? "F" : "f"
        elsif bombed? #=> if bombed? == true for the tile and it was explored ending the game return "X" otherwise show "B"
            explored? ? "X" : "B"
        else #=> for none flagged or none explored tiles show the adjacent bomb count
            adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
        end
    end




end




require_relative 'tile'

class Board
    attr_reader :grid_size, :num_bombs #=> allows read only access to grid_size and :num_bombs

    def initialize(grid_size, num_bombs) #=> initializing new board object
        @grid_size, @num_bombs = grid_size, num_bombs #=> setting instance variables to parameters passed
        #=> ^^ use these variables to create the board using the generate_board method
        generate_board #=> calling the generate_board method
    end

    def [](pos) #=> setting [pos] == [1,1] to equal @grid[row][col]
        row, col = pos #=> setting pos [1,1] to row = 1 and col = 1
        @grid[row][col] #=> find the position in the grid
    end

    def lost? #=> method to check whether the player lost
        @grid.flatten.any? { |tile| tile.bombed? && tile.explored? }
    end #=> makes @grid a 1D array and checks if any of the tile bombs and explored meaning the explored tile is bomb and the play loses

    def render(reveal = false) #=> render method by default sets reveal to false
        @grid.map do |row| 
            row.map do |tile|
                reveal ? tile.reveal : tile.render
            end.join("")
        end.join("\n") #=> taking each row of the grid and look at each tile if reveal is true or tile.reveal if false tile.render
    end

    def reveal #=> works with the #render to display the tiles of the board correctly
        render(true)
    end

    def won? #=> method to check to see if the play has won 
        @grid.flatten.all? { |tile| tile.bombed? != tile.explored? } 
    end


    private

    def generate_board #=> generates the board with the information from the initialize method
        @grid = Array.new(@grid_size) do |row| #=> creating a 2D array that is the @grid_size by @grid_size
            Array.new(@grid_size) { |col| Tile.new(self, [row, col]) } #=> making each pos of the board a instance of Tile object
        end

        plant_bombs #=> calling plant bombs 
    end

    def plant_bombs #=> method adds flipps the boolean of random tiles within the @grid
        total_bombs = 0 #=> creating total_bombs variable to keep track of # of bombs

        while total_bombs < @num_bombs #=> create bombs until total equals number specified
            rand_pos = Array.new(2) { rand(@grid_size) } #=> creating a random pos 
            #=> where each position is within the @grid_size

            tile = self[rand_pos] #=> setting the random position tile
            next if tile.bombed? #=> if tile is already a bomb the next

            tile.plant_bomb #=> plant the bomb switching the boolean
            total_bombs += 1 #=> adding 1 to the total_bombs 
        end

        nil #=> return nil 
    end
end

class Tile
    DELTAS = [
        [-1, -1],
        [-1,  0],
        [-1,  1],
        [ 0, -1],
        [ 0,  1],
        [ 1, -1],
        [ 1,  0],
        [ 1,  1]
    ].freeze

    attr_reader :position

    def initialize(board, position)
        @board, @position = board, position
        @bombed, @explored, @flagged = false, false, false
    end

    def bombed?
        @bombed
    end

    def explored?
        @explored
    end

    def flagged?
        @flagged
    end

    

  
end

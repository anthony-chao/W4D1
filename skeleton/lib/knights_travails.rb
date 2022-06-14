require 'byebug'
require_relative '00_tree_node.rb'

class KnightPathFinder

    POSSIBLE_MOVES = [
        [-1, -2],
        [-2, -1],
        [-1, 2],
        [-2, 1],
        [1, -2],
        [2, -1],
        [1, 2],
        [2, 1],
    ]

    
    def self.valid_moves(pos)
        #contains all possible moves
        valid_moves = []

        x, y = pos
        POSSIBLE_MOVES.each do |(i, j)|
            new_position = [x + i, y + j]

            if new_position.all? { |coordinates| coordinates >= 0 && coordinates < 8 }
                valid_moves << new_position
            end
        end
        
        valid_moves
    end
    
    def initialize(start_position)
        @start_position = start_position
        @considered_positions = [start_position]

        build_move_tree
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(@start_position)
        nodes = [root_node]
        
        until nodes.empty?
            current_node = nodes.shift
            current_pos = current_node.value
            new_move_positions(current_pos).each do |next_move|
                next_nodes = PolyTreeNode.new(next_move)
                current_node.add_child(next_nodes)
                nodes << next_nodes
            end
        end
            
    end 
    
    def new_move_positions(pos)
        #filter out possible moves and reject visited moves
        debugger
        new_positions = []

        if KnightPathFinder.valid_moves(pos).include?(@considered_positions)
            @considered_positions.shift     #==> []
            new_positions += @considered_positions.push(KnightPathFinder.valid_moves(pos))
        end

        new_positions
    end
    
    def find_path(end_position)
        end_node = self.root_node.dfs(end_position)

        self.trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        nodes = []

        current_node = end_node
        until current_node.parent.nil?
            nodes << current_node
            current_node = current_node.parent
        end

        nodes
    end
    
end
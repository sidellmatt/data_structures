require_relative "polytree_node.rb"
require "byebug"

class KnightPathFinder

    attr_accessor :root_node, :considered_positions
    
    
    def initialize(starting_position)
        
        x, y = starting_position[0], starting_position[1]
        @root_node = PolyTreeNode.new([x, y])
        
        @considered_positions = []
        considered_positions << root_node.value
        
        self.build_move_tree

    end


    def build_move_tree
        
        queue = Queue.new
        
        first_moves = new_move_positions(root_node.value)
        first_moves.each do |move|
            queue.enqueue(PolyTreeNode.new(move))
            queue.peek(-1).parent = root_node
        end

        until queue.empty?
            next_node = queue.dequeue
            moves = new_move_positions(next_node.value)
            moves.each do |move|
                queue.enqueue(PolyTreeNode.new(move))
                queue.peek(-1).parent = next_node
            end
        end

    end


    def valid_moves(pos)
        
        x, y = pos[0], pos[1]
        valid_moves = []
        
        possible_moves = [
            [x + 2, y + 1], 
            [x + 2, y - 1],
            [x - 2, y + 1],
            [x - 2, y -1],
            [x + 1, y + 2],
            [x + 1, y- 2],
            [x - 1, y + 2],
            [x - 1, y - 2]
        ]

        possible_moves.each do |move|
            valid_moves << move if move[0] < 9 && move[0] > 0 && move[1] < 9 && move[1] > 0
        end

        valid_moves

    end


    def new_move_positions(pos)
        
        valid = valid_moves(pos)
        new_positions = []
        
        valid.each do |new_pos|
            new_positions << new_pos if !considered_positions.include?(new_pos)
        end
        
        considered_positions << ["New:  "] if new_positions.length > 0 
        new_positions.each do |pos|
            considered_positions << pos
        end
        
        new_positions

    end


end

pathfinder = KnightPathFinder.new([1,1])
p pathfinder.considered_positions

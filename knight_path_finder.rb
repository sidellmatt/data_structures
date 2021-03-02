require_relative "polytree_node.rb"
require "byebug"

class KnightPathFinder

    attr_accessor :root_node, :considered_positions, :visualization
    
    
    def initialize(starting_position)
        
        x, y = starting_position[0], starting_position[1]
        @root_node = PolyTreeNode.new([x, y])
        
        @considered_positions = Queue.new
        considered_positions.enqueue(root_node)
        
        self.build_move_tree
        @visualization = [root_node]

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
        new_positions = Queue.new
        
        valid.each do |new_pos|
            new_positions.enqueue(PolyTreeNode.new(new_pos)) if !considered_positions.include?(PolyTreeNode.new(new_pos))
        end
        
        new_positions.each do |pos|
            considered_positions.enqueue(pos)
        end
        
        new_positions

    end


    def print_move_tree(node)
        
        node.children.each do |child|
            return child.value if child.children.empty?
            visualization << child.print_move_tree(child)
        end
        
        visualization.each do |move|
            p move.value
        end

    end


end

pathfinder = KnightPathFinder.new([0,0])
pathfinder.print_move_tree(PolyTreeNode.new([0,0]))
p pathfinder.considered_positions
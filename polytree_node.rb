require_relative 'diy_adts.rb'

class PolyTreeNode
    
    attr_accessor :value, :parent, :children
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end


    def parent=(node)
        
        if @parent
            @parent.children.each_with_index do |child, index|
                if child == self
                    @parent.children.delete_at(index)
                end
            end

            @parent = node
            
            if node
                node.children << self
            end

        else
            @parent = node
            if node
                node.children << self
            end
            return @parent 
        end

    end


    def add_child(child_node)
        child_node.parent = self
    end


    def remove_child(child_node)
        
        @children.each_with_index do |child, index|
            if child == child_node
                @children.delete_at(index)
                break
            end
            raise "That is not a child of this node.  "
        end

        child_node.parent = nil

    end


    def dfs(target_value)
        
        return self if target_value == value

        @children.each do |child|
            subresult = child.dfs(target_value)
            return subresult if subresult
        end

        return nil

    end


    def bfs(target_value)
        
        return self if target_value == value
        
        queue = Queue.new
        queue.enqueue(self)

        until queue.empty?
            subresult = queue.dequeue
            return subresult if target_value == subresult.value
            if subresult.children.length > 0
                subresult.children.each do |child|
                    queue.enqueue(child)
                end
            end
        end

        return nil

    end

end
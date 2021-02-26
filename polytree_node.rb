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
            
            unless node
                node.children << self
            end
            
            return

        end

        @parent = node
        node.children << self
        return @parent

    end


    def add_child(child_node)
        child_node.parent = self
    end


    def remove_child(child_node)
        
        @children.each_with_index do |child, index|
            if child == child_node
                @children.delete_at(index)
            end
        end

        child_node.parent = nil

    end

end
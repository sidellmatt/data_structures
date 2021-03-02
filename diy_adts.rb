class Stack

    def initialize
        @stack = []
    end

    def push(el)
        @stack << el
    end

    def pop
        @stack.pop
    end

    def peek
        @stack[-1]
    end

end




class Queue

    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el
    end

    def dequeue
        @queue.shift
    end

    def peek(idx)
        @queue[idx]
    end

    def empty?
        @queue.length == 0
    end

    def include?(el)
        @queue.each do |ele|
            return true if ele == el
        end
        false
    end

    def each
        @queue.each do |ele|
            ele
        end
    end

end




class Map

    def initiialize
        @map = []
    end

    def set(key, value)
        
        @map.each_with_index do |pair, index|
            if pair[0] == key
                @map[idx][1] = value
                return
            end
        end

        @map << [key, value]

    end

    def get(key)
        
        @map.each do |pair|
            if pair[0] == key
                return pair[1]
            end
        end

        nil

    end

    def delete(key)

        index = nil
        
        @map.each_with_index do |pair, idx|
            if pair[0] == key
                index = idx
            end
        end

        @map.delete_at(index)

    end

    def show
        @map
    end

end
# Phase 2
class Queue
    def initialize(store = [])
        @store = store
    end

    def peek
        @store.last
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def enqueue(item)
        @store.push(item)
    end

    def dequeue
        @store.shift
    end

end

# p test = Queue.new([2,3,4,5])



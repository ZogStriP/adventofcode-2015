# https://en.wikipedia.org/wiki/Pairing_heap

class PriorityQueue

  class PairingTree
    attr_reader :data, :priority, :heaps

    def initialize(data, priority)
      @data = data
      @priority = priority
      @heaps = []
    end

    def add(h)
      @heaps.push(h)
      self
    end
  end

  def initialize
    @root = nil
  end

  def push(data, priority)
    @root = merge(@root, PairingTree.new(data, priority))
  end

  def pop
    return if @root.nil?
    root = @root
    @root = merge_pairs(@root.heaps)
    root.data
  end

  private

  def merge_pairs(heaps)
    return if heaps&.empty?
    heaps.size == 1 ? heaps[0] : merge(merge(heaps.pop, heaps.pop), merge_pairs(heaps))
  end

  def merge(h1, h2)
    return h2 if h1.nil?
    return h1 if h2.nil?
    h1.priority < h2.priority ? h1.add(h2) : h2.add(h1)
  end

end


require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
    self.start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    store[index] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" unless length > 0
    self.length -= 1
  end

  # O(1) ammortized
  def push(val)
    resize! if self.length == self.capacity
    self.length += 1
    self[length - 1] = val
  end

  # O(1)
  def shift
  end

  # O(1) ammortized
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless index >= 0 && index < length
  end

  def resize!
    arr = self.store
    self.capacity = self.capacity * 2
    self.store = StaticArray.new(self.capacity)
    (0...self.length).each do |i|
      self[i] = arr[i]
    end
  end
end

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
  def [](idx)
    check_idx(idx)
    store[(start_idx + idx) % capacity]
  end

  # O(1)
  def []=(idx, val)
    check_idx(idx)
    store[(start_idx + idx) % capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" unless length > 0
    val = self[length - 1]
    self.length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if length == capacity
    self.length += 1
    self[length - 1] = val
    nil
  end

  # O(1)
  def shift
    raise "index out of bounds" if (length == 0)
    val = self[0]
    self.start_idx = (start_idx + 1) % capacity
    self.length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == capacity
    self.start_idx = (start_idx - 1) % capacity
    self.length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_idx(idx)
    unless idx >= 0 && idx < length
      raise "index out of bounds"
    end
  end

  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i]}

    self.capacity = new_capacity
    self.store = new_store
    self.start_idx = 0
  end
end

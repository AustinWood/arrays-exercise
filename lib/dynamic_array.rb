require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  # O(1)
  def [](idx)
    check_idx(idx)
    store[idx]
  end

  # O(1)
  def []=(idx, val)
    check_idx(idx)
    store[idx] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" unless length > 0
    self.length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible resize.
  def push(val)
    resize! if length == capacity
    self.length += 1
    self[length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if (length == 0)
    val = self[0]
    (1...length).each do |i|
      self[i - 1] = self[i]
    end
    self.length -= 1
    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity
    self.length += 1
    (length - 2).downto(0).each { |i| self[i + 1] = self[i] }
    self[0] = val
    nil
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_idx(idx)
    raise "index out of bounds" unless idx >= 0 && idx < length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times { |i| new_store[i] = self[i]}

    self.capacity = new_capacity
    self.store = new_store
  end
end

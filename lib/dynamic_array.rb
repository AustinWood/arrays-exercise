require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
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

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if self.length == self.capacity
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

  def check_index(index)
    raise "index out of bounds" unless index >= 0 && index < length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    arr = self.store
    self.capacity = self.capacity * 2
    self.store = StaticArray.new(self.capacity)
    (0...self.length).each do |i|
      self[i] = arr[i]
    end
  end
end

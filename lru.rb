class Node
  attr_accessor :key, :value, :prev_node, :next_node

  def initialize(key, value, prev_node, next_node)
    @value = value
    @key = key
    @prev_node = prev_node
    @next_node = next_node
  end
end

class LRU
  def initialize(max_items)
    if (!max_items.instance_of?(Integer)) || (max_items < 1)
      raise ArgumentError, "Invalid max items. Must be positive integer."
    end
    @max_items = max_items
    @table = {}
    @head = nil
    @tail = nil
    @num_items = 0
  end

  def set(key, val)
    @num_items += 1
    if @num_items > @max_items
      @num_items = @max_items
      @head = @head.next_node
      @table.delete(@head.prev_node.key)
      @head.prev_node = nil
    end

    new_node = Node.new(key, val, @tail, nil)
    @head = new_node if @tail == nil
    @tail.next_node = new_node if @tail != nil
    @tail = new_node
    @table[key] = new_node
  end

  def get(key)
    res = @table[key]
    return res if res.nil?
    return res.value if res.next_node == nil

    if res.prev_node != nil 
      res.prev_node.next_node = res.next_node
    else
      @head = res.next_node
      @head.prev_node = nil
    end

    @tail.next_node = res
    res.next_node = nil
    res.prev_node = @tail
    @tail = res
    res.value
  end
end

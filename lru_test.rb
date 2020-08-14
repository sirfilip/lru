require 'minitest/autorun'
require './lru'


describe LRU do
  it 'can hold max items' do
    lru = LRU.new(2)
    lru.set('a', 1)
    lru.set('b', 2)
    lru.set('c', 3)
    assert_equal 2, lru.instance_variable_get("@table").size
  end

  it 'removes the least visited item' do
    lru = LRU.new(2)
    lru.set('a', 1)
    lru.set('b', 2)
    lru.get('a')
    lru.set('c', 3)
    assert lru.get('b').nil?
    assert lru.get('a') == 1
    lru.set('d', 4)
    assert lru.get('c').nil?
    assert lru.get('a') == 1
  end

  it 'guars against invalid max size' do
    assert_raises ArgumentError do
      LRU.new(0)
    end
  end
end

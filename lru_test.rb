require 'minitest/autorun'
require './lru'


describe LRU do
  it 'can hold max items' do
    lru = LRU.new(2)
    lru.set('a', 1)
    lru.set('b', 2)
    lru.set('c', 3)
    assert_equal 2, lru.num_items
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
end

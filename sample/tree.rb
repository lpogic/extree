require 'extree'

class Tree
  include Extree
  
  def initialize value = nil, &b
    @value = value
    @nodes = []
    # sets self as current scope and call given block
    scope! &b
  end

  # define special scoping method
  def! :tr do |value = nil, &b|
    @nodes << Tree.new(value, &b)
  end

  # print the tree in more human readable form
  def inspect depth = 0
    spaces = " " * (depth << 1)
    nodes = @nodes.empty? ? "" : "\n#{@nodes.map{ _1.inspect(depth + 1)}.join("\n")}\n#{spaces}"
    "#{spaces}<#{@value}#{nodes}>"
  end
end

tree = Tree.new do
  tr! 1
  tr! 2 do
    tr! 3
  end
  tr! 4 do
    tr! 5 do
      tr! 6
    end
  end
  tr! 7
end

p tree

# Output:
# <
#   <1>
#   <2
#     <3>
#   >
#   <4
#     <5
#       <6>
#     >
#   >
#   <7>
# >
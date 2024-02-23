extree
===

DSL for building trees

Installation
---
```
gem install extree
```

Usage
---
```RUBY
require 'extree'

class Tree
  include Extree
  
  def initialize value = nil
    @value = value
    @nodes = []
  end

  # define special scoping method for tree building
  def! :t do |value, &b|
    tree = Tree.new(value)
    @nodes << tree
    scope! tree, &b
  end

  def inspect depth = 0
    spaces = " " * (depth << 1)
    nodes = @nodes.empty? ? "" : "\n#{@nodes.map{ _1.inspect(depth + 1)}.join("\n")}\n#{spaces}"
    "#{spaces}<#{@value.inspect}#{nodes}>"
  end
end

# include Extree & Extree::Branch to prepare main scope method redirection
include Extree
include Extree::Branch

def! :t do |value, &b|
  scope! Tree.new(value), &b
end




tree = t! 0 do
  t! 1
  t! 2 do
    t! 2.1
  end
  t! 3 do
    t! 3.1 do
      t! "3.1.1"
    end
  end
  t! 4
end

p tree

# Output:
# <0
#   <1>
#   <2
#     <2.1>
#   >
#   <3
#     <3.1
#       <"3.1.1">
#     >
#   >
#   <4>
# >
```

Authors
---
- Łukasz Pomietło (oficjalnyadreslukasza@gmail.com)
- JAMES ()

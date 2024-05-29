require 'extree'

module Parent
  include Extree

  def! :div do |**na, &b|
    element = Element.new "div"
    scope! element, **na, &b
    push_element element
  end

  def! :span do |**na, &b|
    element = Element.new "span"
    scope! element, **na, &b
    push_element element
  end

  def push_element element
    element
  end
end

class Element
  include Parent

  def initialize tag
    @attributes = {}
    @children = []
    @tag = tag
  end

  def push_element element
    @children << element
  end

  def class=(classs)
    @attributes[:class] = classs
  end

  def id=(id)
    @attributes[:id] = id
  end

  def to_html depth = 0
    spaces = " " * (depth << 1)
    attributes = @attributes.map{|k, v| " #{k}='#{v}'" }.join
    children = @children.map{|ch| "\n" + ch.to_html(depth + 1) }.join
    "#{spaces}<#{@tag}#{attributes}>#{children}#{ "\n#{spaces}" if !@children.empty? }</#{@tag}>"
  end
end

include Parent

#######################################################

@first_div_id = "first-div-id"

html = div! class: "dividor" do
  span! id: :spanner do
    div! class: "first", id: @first_div_id
    div! class: "second"
  end
end

puts html.to_html

# Output:
# <div class='dividor'>
#   <span id='spanner'>
#     <div class='first' id='first-div-id'></div>
#     <div class='second'></div>
#   </span>
# </div>
class Node
    attr_reader :value, :children
    def initialize(value, children =[])
        @value = value
        @children = children
    end
    
end

#           a
#          / \
#         b   c
#        / \  / \
#       d  e f   g


#leaf nodes
d = Node.new("d")
e = Node.new("e")
f = Node.new("f")
g = Node.new("g")

#internal nodes
b = Node.new("b", [d,e])
c = Node.new("c", [f,g])

#root note
a = Node.new("a", [b,c])

root_node = a

#find g
p root_node.children[1].children[1]



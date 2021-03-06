module Searchable

    def dfs(target = nil, &prc)
        raise "Target & proc must be passed in" if [target, prc].none?
        prc ||= Proc.new { |node| node.value == target }

        return self if prc.call(self)

        self.children.each do |child|
            result = child.dfs(&prc)
            if !result.nil?
                return result 
            end
        end

        nil        
    end

    def bfs(target = nil, &prc)
        raise "Target & proc must be passed in" if [target, prc].none?
        prc ||= Proc.new { |node| node.value == target }

        nodes = [self]
        until nodes.empty?
        node = nodes.shift

            if prc.call(node)
                return node 
            else
                nodes.concat(node.children)
            end
        end
    end
    
end

class PolyTreeNode
    include Searchable

    attr_reader :parent
    attr_accessor :value
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
  
    end

    def children
        @children
    end

    def parent=(node)  
        if @parent   #if parent is truthy, not nil
            old_parent = @parent    #set self old parent to node (parent value)
            old_parent.children.delete(self)    #delete self from old parent
        end
        
        @parent = node  #set node as new parents
        if !node        #if not parent
            return      #return
        else
            @parent.children << self if !@parent.children.include?(self) #else, add self as children of node only if child is not children of parent already
        end
    end

    def add_child(child)
        child.parent = self     #pass self to #parent=
    end

    def remove_child(child)     
        if !self.children.include?(child)      #if child is not self.children
            raise "Can't remove that's not my child"
        else
            child.parent = nil
        end
    end

end




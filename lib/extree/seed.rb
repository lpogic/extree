module Extree
  module Seed
    BRANCH_METHOD_PREFIX = "extree_branch_".freeze

    @@call_stack = []
    @@call_roots = []

    class << self
      def stack
        @@call_stack
      end

      def roots
        @@call_roots
      end

      def current root
        @@call_roots.include?(root) ? @@call_stack.last : root
      end

      def push object
        @@call_stack.push object
      end
    
      def pop
        @@call_stack.pop
      end

      def open_scope object
        @@call_roots << object
      end

      def close_scope object
        @@call_roots.delete_at @@call_roots.index(object)
      end
    end

    def self!
      Seed.current self
    end

    def extree_respond_to? name
      top = Seed.current self
      top.respond_to?("#{name}=") || top.respond_to?("#{BRANCH_METHOD_PREFIX}#{name}")
    end

    def extree_method_missing name, *a, **na, &b
      top = Seed.current self
      branch_method = "#{BRANCH_METHOD_PREFIX}#{name}".to_sym
      return top.send(branch_method, *a, **na, &b) if top.respond_to? branch_method
      setter = "#{name}=".to_sym
      if top.respond_to? setter
        return top.send(setter, a) if !a.empty?
        return top.send(setter, na) if !na.empty?
        return top.send(setter, b) if block_given?
        return top.send(setter)
      end
      no_method_error = NoMethodError.new("extree method missing `#{name}!` for #{top.class}")
      raise no_method_error
    end

    # Call method on receiver, ignore call stack
    def send! method, *a, **na, &b
      send "#{BRANCH_METHOD_PREFIX}#{method}", *a, **na, &b
    end

    def host! &b
      return self if !b
      Seed.push self
      result = b.call self
      Seed.pop
      result
    end

    def scope! scoped = nil, *a, **na, &b
      scoped ||= self
      Seed.open_scope self
      scoped.host! *a, **na, &b
      Seed.close_scope self
      scoped
    end
    
  end
end
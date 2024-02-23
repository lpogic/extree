require_relative 'seed'

module Extree
  module Root
    include Seed

    def respond_to? name
      super || (name.end_with?("!") && extree_respond_to?(name[...-1]))
    end

    def method_missing name, *a, **na, &b
      if name.end_with? "!"
        extree_method_missing name[...-1], *a, **na, &b
      else 
        super
      end
    end

    def host! *a, **na, &b
      a.each do |k|
        send("#{k}=", SINGLETON)
      end
      na.each do |k, v|
        send("#{k}=", v)
      end
      super(&b)
    end
  end
end
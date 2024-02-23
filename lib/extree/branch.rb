require_relative 'seed'

module Extree
  module Branch
    def def! name, &b
      define_method "#{Seed::BRANCH_METHOD_PREFIX}#{name}", &b
    end

    @@redef_index = 0

    def redef! name, &b
      @@redef_index = index = @@redef_index.next
      redefined = "#{Seed::BRANCH_METHOD_PREFIX}#{index}_#{name}"
      branch_method = "#{Seed::BRANCH_METHOD_PREFIX}#{name}"
      alias_method redefined, branch_method
      define_method branch_method do |*a, **na, &bl|
        b.call redefined, *a, **na, &bl
      end
    end
  end
end
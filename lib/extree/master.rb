require_relative 'root'
require_relative 'branch'

module Extree
  include Root

  SINGLETON = Object.new

  def self.included(mod)
    mod.extend Branch
  end
end
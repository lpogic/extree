require_relative 'extree/root'
require_relative 'extree/branch'

module Extree
  include Root

  SINGLETON = Object.new

  def self.included(mod)
    mod.extend Branch
  end
end
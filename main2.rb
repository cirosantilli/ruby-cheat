main2_i = 2

Main2_const = 2

def main2_f()
  return 2
end

def self.f()
  return 2
end

module Main2
  def self.f()
    return 2
  end
end

module AnyName
  def self.f()
    return 2
  end
end

require_relative('main3')

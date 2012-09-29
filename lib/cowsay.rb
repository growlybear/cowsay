require "pathname"

module Cowsay
  def self.new_cow(*args)
    Cow.new(*args)
  end

  class Cow
    def say(message)
      perl_path = "/usr/bin/perl"

      cowsay_path   = (Pathname(__FILE__).dirname + "../bin/cowsay").to_s
      cowthink_path = (Pathname(__FILE__).dirname + "../bin/cowthink").to_s
      cows_path     = (Pathname(__FILE__).dirname + "cowsay/cows").to_s

      env = {
        'COWPATH' => cows_path
      }

      IO.popen([env, perl_path, cowsay_path, message]) do |process|
        process.read
      end
    end
  end
end

module Cowsay
  class Cow
    def say(message)
      # /usr/bin/perl
      IO.popen(['cowsay', message]) do |process|
        process.read
      end
    end
  end
end

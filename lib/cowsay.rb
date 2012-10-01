require "pathname"

module Cowsay
  def self.new_cow(*args)
    Cow.new(*args)
  end

  def self.cowfiles(options={})
    fs = options.fetch(:fs) { Pathname }
    paths = fs.glob("#{cowfile_dir}/*.cow")
    paths.map { |path|
      path.basename(".cow")
    }.map(&:to_s).grep(/\A\w/).sort
  end

  def self.cowfile_dir
    (Pathname(__FILE__).dirname + "cowsay/cows").expand_path
  end

  class Cow
    def initialize(options = {})
      @io      = options.fetch(:io)      { IO }
      @cowfile = options.fetch(:cowfile) { 'default' }
    end

    def say(message)
      perl_path = "/usr/bin/perl"

      cowsay_path   = (Pathname(__FILE__).dirname + "../bin/cowsay").to_s
      cowthink_path = (Pathname(__FILE__).dirname + "../bin/cowthink").to_s
      cows_path     = (Pathname(__FILE__).dirname + "cowsay/cows").to_s

      env = {
        'COWPATH' => cows_path
      }
      args = %W[-f #{@cowfile}]

      @io.popen([env, perl_path, cowsay_path, *args], 'r+') do |process|
        process.write(message)
        process.close_write
        process.read
      end
    end
  end
end

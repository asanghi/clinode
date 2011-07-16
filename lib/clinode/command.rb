require 'fileutils'

if RUBY_PLATFORM =~ /mswin|mingw/
  begin
    require 'win32/open3'
  rescue LoadError
    warn "You must 'gem install win32-open3' to use the github command on Windows"
    exit 1
  end
else
  require 'open3'
end

module Clinode
  class Command
    include FileUtils

    def initialize(block)
      (class << self;self end).send :define_method, :command, &block
    end

    def call(*args)
      arity = method(:command).arity
      args << nil while args.size < arity
      send :command, *args
    end

    def helper
      @helper ||= Helper.new
    end

    def options
      Clinode.options
    end

    def run(method, command)
      if command.is_a? Array
        command = [ 'git', command ].flatten
      else
        command = 'git ' + command
      end

      send method, *command
    end

    def sh(*command)
      Shell.new(*command).run
    end

    def die(message)
      puts "=> #{message}"
      exit!
    end

    def highline
      @highline ||= HighLine.new
    end

    def shell_user
      ENV['USER']
    end

    def current_user?(user)
      user == shell_user
    end

    class Shell < String
      attr_reader :error
      attr_reader :out

      def initialize(*command)
        @command = command
      end

      def run
        Clinode.debug "sh: #{command}"

        out = err = nil
        Open3.popen3(*@command) do |_, pout, perr|
          out = pout.read.strip
          err = perr.read.strip
        end

        replace @error = err unless err.empty?
        replace @out = out unless out.empty?

        self
      end

      def command
        @command.join(' ')
      end

      def error?
        !!@error
      end

      def out?
        !!@out
      end
    end
  end
end
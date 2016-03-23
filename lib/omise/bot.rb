require "omise/bot/version"

module Omise
  class Bot
    def initialize
      @services = {}
      @commands = {}
      yield self if block_given?
    end

    module Services
      def integrate(name, service)
        service.bot = self
        @services[name] = service
      end

      def configure(name = nil)
        if name
          yield @services[name]
        else
          yield self
        end
      end

      def respond_to?(method)
        @services.key?(method) || super
      end

      def method_missing(method, *args, &block)
        if @services.key?(method)
          @services[method]
        else
          super
        end
      end
    end

    class NoCommandError < StandardError
      def initialize(command_name)
        super "undefined command `#{command_name}'"
        @command_name = command_name
      end

      attr_reader :command_name
    end

    module Commands
      def exec(str, channel, user)
        call_command(str, channel, user)
        true
      rescue NoCommandError => e
        channel.post "I don't know how to #{e.command_name}"
        false
      rescue
        channel.post "Something went wrong but that's all I know"
        false
      end

      def register(name, &block)
        @commands[name.to_s] = block
        name.to_s
      end

      def help(command_name, desc)
        @help ||= {}
        @help[command_name] = desc
      end

      def get_help
        @help.map { |k,v| "* /ob #{k} - #{v}" }.join("\n")
      end

      def clear_help
        @help = {}
      end

      private

      def call_command(str, *args)
        command_name, payload = str.strip.split(" ", 2)
        command = @commands[command_name.to_s]

        if command
          command.call(payload, *args)
        else
          raise NoCommandError, command_name
        end
      end
    end

    include Services
    include Commands
  end
end

require "ruboty/feedly/actions/feedly"

module Ruboty
  module Handlers
    class Feedly < Base
      on /ニュース/, name: 'feedly', description: 'output news feed on feedly'
    end

    def feedly(message)
      Ruboty::Feedly::Actions::Feedly.new(message).call
    end
  end
end

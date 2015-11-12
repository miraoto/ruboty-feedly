require "ruboty/feedly/actions/feedly"

module Ruboty
  module Handlers
    class Feedly < Base
      on /医療ニュースある？ (?<number>.*?)\z/, name: 'feedly', description: 'output news feed on feedly'
    end

    def feedly(message)
      Ruboty::Feedly::Actions::Feedly.new(message).call
    end
  end
end

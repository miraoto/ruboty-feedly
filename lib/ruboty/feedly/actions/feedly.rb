module Ruboty
  module Feedly
    module Actions
      class Feedly < Ruboty::Actions::Base
        def call
          message.reply(news_feed)
        end

        private

        def news_feed
          'none'
        end
      end
    end
  end
end

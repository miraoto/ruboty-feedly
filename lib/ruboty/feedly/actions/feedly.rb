require 'feedlr'

module Ruboty
  module Feedly
    module Actions
      class Feedly < Ruboty::Actions::Base
        def call
          message.reply(news_feed)
        end

        private

        # rate limiting of 250 API calls a day(https://developer.feedly.com/v3/#rate-limiting
        # API access token expired 7 days
        def news_feed
          begin
            client = Feedlr::Client.new(oauth_access_token: ENV['FEEDLY_OAUTH_ACCESS_TOKEN'])
            @latest_list = {}
            client.user_unread_counts.unreadcounts.each do |unread_articles|
              next if unread_articles['count'] == 0
              unread_article_items = client.stream_entries_contents(unread_articles.id, unreadOnly: true).items
              next if unread_article_items.empty?

              unread_article_items.each do |article|
                @latest_list[article.alternate[0].href] = "◼︎ <a href='#{article.alternate[0].href}'>#{article.title} - #{article.origin.title}</a>"
              end
              client.mark_article_as_read(unread_articles.id)
            end
            @latest_news = @latest_list.values.join("<br>")
          rescue => evar
            fail evar
          end
          @latest_news
        end
      end
    end
  end
end

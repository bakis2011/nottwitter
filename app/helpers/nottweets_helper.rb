module NottweetsHelper
  REGEXP = /((@)[\w\-]+|(#)[\w\-]+)/
  def linkify_keywords(nottweet)
    if nottweet
      return nottweet.content.gsub(REGEXP) do |match|
        case $~.captures.compact[1]
          when "@" then
            if user = User.find_by(username: match[1..-1])
              author = Nottweet.find_by(content: nottweet.content).user
              Notification.find_or_create_by(author: author, user: user, action: "mention", nottweet: nottweet)
              "<a href='/users/#{user.id}'>#{match}</a>"
            else
              match
            end
          when "#" then "<a href='#'>#{match}</a>"
        end
      end
    end
  end
end


module NottweetsHelper
  REGEXP = /((@)[\w\-]+|(#)[\w\-]+)/
  def linkify_keywords(nottweet)
    if nottweet
      return nottweet.content.gsub(REGEXP) do |match|
        case $~.captures.compact[1]
          when "@" then
            if user = User.find_by(username: match[1..-1])
              Notification.find_or_create_by(author: current_user, user: user, action: "mention", nottweet: nottweet)
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


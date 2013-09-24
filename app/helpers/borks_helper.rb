module BorksHelper
  REGEXP = /((@)[\w\-]+|(#)[\w\-]+)/
  def linkify_keywords(bork)
    if bork
      return bork.content.gsub(REGEXP) do |match|
        case $~.captures.compact[1]
          when "@" then
            if user = User.find_by(username: match[1..-1])
              author = Bork.find_by(content: bork.content).user
              Notification.find_or_create_by(author: author, user: user, action: "mention", bork: bork)
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


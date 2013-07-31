module NottweetsHelper
  REGEXP = /((@)[\w\-]+|(#)[\w\-]+)/
  def linkify_keywords(content)
    # TODO Change this, I don't like this.
    if content
      return content.gsub(REGEXP) do |match|
        case $~.captures.compact[1]
          when "@" then
            id = User.find_by(username: match[1..-1]).id
            "<a href='/users/#{id}'>#{match}</a>"
          when "#" then "<a href='/search/#{match[1..-1]}'>#{match}</a>"
        end
      end
    end
  end
end


link = $('a[href="/users/<%= @user.id %>/unfollow"]')
link.text("Follow")
link.attr("href", "/users/<%= @user.id %>/follow")

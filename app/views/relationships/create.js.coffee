link = $('a[href="/users/<%= @user.id %>/follow"]')
link.text("Unfollow")
link.attr("href", "/users/<%= @user.id %>/unfollow")

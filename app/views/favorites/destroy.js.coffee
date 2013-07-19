link = $('a[href="/nottweets/<%= @nottweet.id %>/unfavorite"]')
link.text("Favorite")
link.attr("href", "/nottweets/<%= @nottweet.id %>/favorite")

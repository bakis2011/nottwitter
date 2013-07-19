link = $('a[href="/nottweets/<%= @nottweet.id %>/favorite"]')
link.text("Unfavorite")
link.attr("href", "/nottweets/<%= @nottweet.id %>/unfavorite")

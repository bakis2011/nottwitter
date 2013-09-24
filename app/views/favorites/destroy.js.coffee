link = $('a[href="/borks/<%= @bork.id %>/unfavorite"]')
link.text("Favorite")
link.attr("href", "/borks/<%= @bork.id %>/favorite")

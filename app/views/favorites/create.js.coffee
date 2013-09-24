link = $('a[href="/borks/<%= @bork.id %>/favorite"]')
link.text("Unfavorite")
link.attr("href", "/borks/<%= @bork.id %>/unfavorite")

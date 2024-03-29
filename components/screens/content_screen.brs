sub init()
    m.content_grid = m.top.FindNode("content_grid")
    m.top.observeField("visible", "on_visible_change")
end sub

sub on_visible_change()
    if m.top.visible then
        m.content_grid.setFocus(true)
    end if
end sub

sub on_feed_changed(obj)
    feed = obj.getData()
    poster_content = createObject("roSGNode","ContentNode")

    for each item in feed
		node = createObject("roSGNode","ContentNode")
	    node.streamformat = "hls"
	    node.title = Substitute("Rozmowa {0}", Str(item.id))
	    node.url = "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8"
	    node.description = item.title
	    node.HDGRIDPOSTERURL = item.thumbnailUrl
	    node.SHORTDESCRIPTIONLINE1 = Substitute("Rozmowa {0}", Str(item.id))
		node.SHORTDESCRIPTIONLINE2 = item.title
	    poster_content.appendChild(node)
    end for
    show_poster_grid(poster_content)
end sub

sub show_poster_grid(content)
  m.content_grid.content=content
  m.content_grid.visible=true
  m.content_grid.setFocus(true)
end sub

function update_config(params)
	m.host = params.config.host
end function
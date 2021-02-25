sub init()
    m.category_screen = m.top.findNode("category_screen")
    m.content_screen = m.top.findNode("content_screen")
	
    m.category_screen.observeField("category_selected", "on_category_selected")
    m.category_screen.setFocus(true)
end sub

sub on_category_selected(obj)
    list = m.category_screen.findNode("category_list")
    item = list.content.getChild(obj.getData())
    load_feed(item.feed_url)
end sub

sub load_feed(url)
    m.feed_task = createObject("roSGNode", "feed_task")
    m.feed_task.observeField("response", "on_feed_response")
    m.feed_task.url = url
    m.feed_task.control = "RUN"
end sub  

sub on_feed_response(obj)
    response = obj.getData()
	data = parseJSON(response)

	if data <> invalid
        m.category_screen.visible = false
        m.content_screen.visible = true
		m.content_screen.feed_data = data
	else
		? "Error while fetching data, returned string is not a JSON one!"
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ? "[main_scene] onKeyEvent", key, press
    return false 
end function

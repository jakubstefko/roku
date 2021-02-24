sub init()
    ? "[main_scene] init"
    m.category_screen = m.top.findNode("category_screen")
    m.content_screen = m.top.findNode("content_screen")
	
    m.category_screen.observeField("category_selected", "onCategorySelected")
    m.category_screen.setFocus(true)
end sub

sub onCategorySelected(obj)
    list = m.category_screen.findNode("category_list")
    item = list.content.getChild(obj.getData())
    loadFeed(item.feed_url)
end sub

sub loadFeed(url)
    m.feed_task = createObject("roSGNode", "FeedTask")
    m.feed_task.observeField("response", "onFeedResponse")
    m.feed_task.url = url
    m.feed_task.control = "RUN"
end sub  

sub onFeedResponse(obj)
    response = obj.getData()
	'turn the JSON string into an Associative Array
	data = parseJSON(response)
	if data <> Invalid and data.items <> invalid
        'hide the category screen and show content screen
        m.category_screen.visible = false
        m.content_screen.visible = true
		' assign data to content screen
		m.content_screen.feed_data = data
	else
		? "FEED RESPONSE IS EMPTY!"
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ? "[main_scene] onKeyEvent", key, press
    return false 
end function

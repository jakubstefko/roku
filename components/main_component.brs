sub init()
    m.category_screen = m.top.findNode("category_screen")
    m.content_screen = m.top.findNode("content_screen")
    m.detail_screen = m.top.findNode("detail_screen")

    m.video_player = m.top.findNode("video_player")
	init_video_player()

    m.category_screen.observeField("category_selected", "on_category_selected")
    m.content_screen.observeField("content_selected", "on_content_selected")
    m.detail_screen.observeField("play_button_pressed", "on_play_button_pressed")

    m.category_screen.setFocus(true)
end sub

sub init_video_player()
    m.video_player.EnableCookies()
	m.video_player.setCertificatesFile("common:/certs/ca-bundle.crt")
	m.video_player.InitClientCertificates()
    m.video_player.notificationInterval=1
	m.video_player.observeFieldScoped("position", "on_player_position_changed")
	m.video_player.observeFieldScoped("state", "on_player_state_changed")
end sub

sub on_player_position_changed(obj)
	? "on_player_position_changed: ", obj.getData()
end sub

sub on_player_state_changed(obj)
    ? "on_player_state_changed: ", obj.getData()
end sub

sub on_play_button_pressed()
    m.detail_screen.visible = false
    m.video_player.visible = true
    m.video_player.setFocus(true)
    m.video_player.content = m.selected_media
    m.video_player.control = "play"
end sub

sub on_category_selected(obj)
    list = m.category_screen.findNode("category_list")
    content_on_visible_change = m.content_screen.findNode("content_screen_title_label")
    content_description = m.content_screen.findNode("content_screen_description")

    item = list.content.getChild(obj.getData())

    content_on_visible_change.text = item.title
    content_description.text = item.description
    
    load_feed(item.feed_url)
end sub

sub on_content_selected(obj)
    index = obj.getData()
    
    m.selected_media = m.content_screen.findNode("content_grid").content.getChild(index)
    m.detail_screen.content = m.selected_media

    m.content_screen.visible = false
    m.detail_screen.visible = true
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
    ' u need to check press, because each button press IRL creates 2 onKeyEvent's
    ' one with press true (onKeyDown) and one with press false (onKeyUp)

    ' return true means that event is handled and will not event-bubble
    
    if key = "back" and press then
        if m.content_screen.visible then
            m.content_screen.visible = false
            m.category_screen.visible = true
            m.category_screen.setFocus(true)
            return true
        else if m.detail_screen.visible then
            m.detail_screen.visible = false
            m.content_screen.visible = true
            m.content_screen.setFocus(true)
            return true
        else if m.video_player.visible then
            m.video_player.visible = false
            m.detail_screen.visible = true
            m.detail_screen.setFocus(true)
            return true
        end if
    end if

    return false 
end function

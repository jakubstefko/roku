sub init()
	m.title = m.top.FindNode("detail_screen_title_label")
	m.description = m.top.FindNode("description")
	m.thumbnail = m.top.FindNode("thumbnail")
	m.play_button = m.top.FindNode("play_button")
	m.top.observeField("visible", "on_visible_change")
	m.play_button.setFocus(true)
end sub

sub on_visible_change()
	if m.top.visible = true then
		m.play_button.setFocus(true)
	end if
end sub

sub on_content_change(obj)
	item = obj.getData()
	m.title.text = item.title
	m.description.text = item.description
	m.thumbnail.uri = item.HDGRIDPOSTERURL
end sub
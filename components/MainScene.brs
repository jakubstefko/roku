sub init()
    ? "[MainScene] init"
    m.categories = m.top.findNode("Categories")
	m.categories.setFocus(true)
End sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ? "[MainScene] onKeyEvent", key, press
    return false 
end function

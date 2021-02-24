sub init()
    ? "[MainScene] init"
    m.label = m.top.findNode("myLabel")
	m.label.setFocus(true)
End sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ? "[MainScene] onKeyEvent", key, press
    return false 
end function

function init()
    ? "[SubScene] init"
    m.categories = m.top.findNode("Categories")
	m.categories.setFocus(true)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
	? "[SubScene] onKeyEvent", key, press
    return false
end function
function init()
    m.category_list = m.top.findNode("category_list")
    m.top.observeField("visible", "on_visible_change")
    m.category_list.setFocus(true)
end function

sub on_visible_change()
    if m.top.visible then
        m.category_list.setFocus(true)
    end if
end sub
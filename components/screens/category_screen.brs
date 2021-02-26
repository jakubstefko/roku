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

function update_config(params)
    categories = params.config.categories
    contentNode = createObject("roSGNode","ContentNode")
    for each category in categories
        node = createObject("roSGNode","category_node")
        node.title = category.title
        node.feed_url = params.config.host + category.feed_url
        node.description = category.description
        contentNode.appendChild(node)
    end for
    m.category_list.content = contentNode
end function
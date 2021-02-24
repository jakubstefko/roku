function init()
    m.category_list = m.top.findNode("CategoryList")
    m.content = m.top.findNode("Content")

    m.category_list.observeField("itemSelected", "onCategorySelected")
    m.category_list.setFocus(true)
end function

sub onCategorySelected(obj)
    ? "onCategorySelected field: ";obj.getField()
    ? "onCategorySelected data: ";obj.getData()
    ? "onCategorySelected checkedItem: ";m.category_list.checkedItem
    ? "onCategorySelected selected ContentNode: "; m.category_list.content.getChild(obj.getData())
    item = m.category_list.content.getChild(obj.getData())
    loadFeed(item.feed_url)
end sub

sub loadFeed(url)
    m.feed_task = createObject("roSGNode", "FeedTask")
    m.feed_task.observeField("response", "onFeedResponse")
    m.feed_task.url = url
    m.feed_task.control = "RUN"
end sub  

sub onFeedResponse(obj)
    ? "onFeedResponse: "; obj.getData()
end sub
#buttonId = -> 
#  queryString = document.location.search
#  n = queryString.indexOf("=") + 1
#  queryString.substring(n, queryString.length)
#
#a = buttonId()
#console.log a
#console.log typeof(a)
#
#console.log document.location.search
#console.log typeof(document.location.search)
#
#organizationId = -> window.location.pathname.split("/")[2]
#b = organizationId()
#console.log b
#console.log typeof(b)



# $ ->
#   $el = $('.filtered-contiainer')
#   listView = new infinity.ListView($el)
#   
#   $('.some-btn-class').click ->
#     type = $(@).data('some-data-attribute')
#     $.ajax {
#       url: "filter/?notification_type=#{buttonId()}"
#       type: "GET"
#       success: (html) ->
#         console.log "right above html"
#         console.log html
#         listView.append($(html))
#       error: (html) ->
#         console.log "error"
#     }

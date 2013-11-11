currentPage = 2
isDone = false

organizationId = -> $('.org-container').data('organization-id')

onShowOrganization = (url_path) ->
 console.log url_path
 if /^\/organizations\/\d$/.test(url_path)
   true
 else
   false


$ ->
  $el = $('.notification-container')
  listView = new infinity.ListView($el)

  $(window).scroll ->
    if $(window).scrollTop() + $(window).height() == $(document).height()
      console.log "scrollcheck"
      if isDone
        console.log "breaking out of ajax scroll function"
        return

      console.log '==> start ajax'
      $.ajax {
        url: "notifications/paginate/#{organizationId()}?page_number=#{currentPage}"
        type: "GET"
        success: (data) ->
          json = null
          html = null

          try
            json = JSON.parse(data)
          catch SyntaxError
            html = data

          if json? && json.flag == true
            console.log "setting global flag to true"
            isDone = true
            return

          console.log '==> appending'
          listView.append($(html))
          currentPage += 1
          console.log "current page is now #{currentPage}"
          console.log '==> appending done'

        error: ->
          console.log "error in infinityNotifications on ajax call"
      }

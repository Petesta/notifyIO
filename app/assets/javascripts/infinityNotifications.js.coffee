current_page = 2
old_html = ""

organizationId = -> $('.org-container').data('organization-id')

$ ->
  $el = $('.notification-container')
  listView = new infinity.ListView($el)

  $(window).scroll ->
    if ($(window).scrollTop() + $(window).height() > $(document).height() - 100)
      $.ajax {
        url: "notifications/paginate/#{organizationId()}?page_number=#{current_page}"    
        type: "GET"
        success: (html) ->
          console.log "right above html"
          console.log typeof(html)

          html = try 
            JSON.parse(html)
          catch SyntaxError
            html
          console.log html

          if old_html != html
            if (html.flag != true)
              listView.append($(html))
              console.log "here"
              current_page += 1
          old_html = html
          console.log current_page
      }

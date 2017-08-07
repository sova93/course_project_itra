$ ->
  if $('.pagination').length && $('#instructions').length
    $(window).scroll ->
      url = $('.pagination a.next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text('...')
        $.getScript(url)
    $(window).scroll()
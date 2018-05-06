jQuery ->
  $(window).scroll ->
    more_posts_url = $('.pagination .next_page a').attr('href')
    if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
      $('.pagination').text('Loading more wikis...')
      $.getScript more_posts_url
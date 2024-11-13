# In config/initializers/bootstrap_pagination_renderer.rb
#
require 'will_paginate/view_helpers/action_view'

class BootstrapPaginationRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    { class: 'pagination justify-content-center' }
  end

  def page_number(page)
    if page == current_page
      "<li class='page-item active'><a class='page-link' href='#'>#{page}</a></li>"
    else
      "<li class='page-item'><a class='page-link' href='#{url(page)}'>#{page}</a></li>"
    end
  end

  def previous_or_next_page(page, text, classname)
    if page
      "<li class='page-item'><a class='page-link' href='#{url(page)}'>#{text}</a></li>"
    else
      "<li class='page-item disabled'><a class='page-link' href='#'>#{text}</a></li>"
    end
  end
end
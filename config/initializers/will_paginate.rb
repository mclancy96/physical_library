# frozen_string_literal: true

WillPaginate::ViewHelpers.pagination_options[:class] = 'pagination justify-content-center'
WillPaginate::ViewHelpers.pagination_options[:previous_label] = '&laquo;'.html_safe
WillPaginate::ViewHelpers.pagination_options[:next_label] = '&raquo;'.html_safe

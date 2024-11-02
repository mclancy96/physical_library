module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :notice
      'primary'
    when :alert
      'danger'
    when :success
      'success'
    when :error
      'danger'
    else
      'secondary'
    end
  end

  def format_date(date)
    date.strftime('%B %d, %Y')
  end
end


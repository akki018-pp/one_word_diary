module ApplicationHelper
  def page_title(title = '')
    base_title = 'ひとこと日記'
    title.present? ? "#{title} | #{base_title}" : base_title
  end
  def flash_color(type)
    case type.to_sym
    when :notice
      'bg-green-900 text-white'
    when :alert, :error
      'bg-red-900 text-white'
    else
      'bg-yellow-900 text-white'
    end
  end
end

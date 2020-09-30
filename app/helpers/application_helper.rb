module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'PoK'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def full_url(path)
    domain = "https://p-of-k.com/"
    "#{domain}#{path}"
  end
end

module ApplicationHelper
  def full_title(title)
    if title.empty? 
      "Twitter"
    else 
      "#{title} | twitter"
    end
  end 
end

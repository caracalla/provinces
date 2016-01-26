module ApplicationHelper
  def replace_newlines(text)
    text.gsub("\n", "<br>").html_safe
  end
end

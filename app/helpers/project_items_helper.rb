module ProjectItemsHelper
  def show_project_item(opts)
    return if opts[:value].blank?
    "<p><b>#{opts[:column]}:</b>&nbsp;&nbsp;  #{opts[:value]}</p>".html_safe
  end

end

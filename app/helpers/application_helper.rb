module ApplicationHelper
  def col_width
    params[:controller] == 'admin/welcome' ? 15 : 16.25
  end
end

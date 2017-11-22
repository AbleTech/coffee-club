module ApplicationHelper
  def col_width
    width =
      if params[:controller] == 'admin/welcome'
        15
      else
        16.25
      end
  end
end

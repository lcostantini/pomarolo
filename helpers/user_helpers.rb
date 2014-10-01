module UserHelpers

  def current_user
    @current_user ||= session[:user]
  end
  
  def user_path
    '/user'
  end
  
  def root_path
    '/'
  end
  
end

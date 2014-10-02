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
  
  def pomodoros_by_date
    Pomodoro.find(user: current_user, created_at: Date.today.to_s, current_pomodoro: "false")
  end
  
  def only_current_pomodoro
    Pomodoro.find(user: current_user, created_at: Date.today.to_s, current_pomodoro: "true").first
  end
  
  def list_interruptions(pomodoro_id)
    Interruption.find(user: current_user, pomodoro: pomodoro_id)
  end
  
end

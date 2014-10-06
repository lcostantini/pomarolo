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
    Pomodoro.find(user: current_user, created_at: Date.today.to_s, current_pomodoro: "false").except(finish: "true")
  end
  
  def only_current_pomodoro
    Pomodoro.find(user: current_user, created_at: Date.today.to_s, current_pomodoro: "true").first
  end
  
  def list_interruptions(pomodoro_id)
    Interruption.find(pomodoro: pomodoro_id)
  end
  
  def pomodoros_created_at(param_date)
    Pomodoro.find(user: current_user, created_at: param_date)
  end
  
end

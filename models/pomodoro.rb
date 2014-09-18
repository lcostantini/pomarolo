class Pomodoro < Ohm::Model
  attribute :description
  attribute :pomarolo
  attribute :interruption
  attribute :finish
  attribute :user
  index :user
  
  def swap attribute
    send "#{attribute.to_s}=".to_sym, !send(attribute)
    save
  end
  
  def state attribute
    !!send(attribute)
  end
  
end

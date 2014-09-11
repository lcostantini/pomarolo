class Pomodoro < Ohm::Model
  attribute :description
  attribute :pomarolo
  attribute :interruption
  attribute :finish
  
  def finished?
    !! finish
  end
end

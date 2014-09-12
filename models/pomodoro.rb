class Pomodoro < Ohm::Model
  attribute :description
  attribute :pomarolo
  attribute :interruption
  attribute :finish
  
  def finished?
    !! finish
  end
  
  def swap_finish
    self.finish = !self.finished?
    self.save
  end
  
end

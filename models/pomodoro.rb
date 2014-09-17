class Pomodoro < Ohm::Model
  attribute :description
  attribute :pomarolo
  attribute :interruption
  attribute :finish
  attribute :user_id
  index :user_id
  
  def finished?
    !! finish
  end
  
  def interruption?
    !! interruption
  end
  
  def swap_finish
    self.finish = !self.finished?
    self.save
  end
  
  def swap_interruption
    self.interruption = !self.interruption?
    self.save
  end
end

class Pomodoro < Ohm::Model
  attribute :description
  attribute :interruption
  attribute :estimate
  attribute :real
  attribute :finish
  attribute :user
  index :user

  def finished?
    !! finish
  end

  def swap_finish
    self.finish = !self.finished?
    self.save
  end
  
  def difference?
    unless self.real.nil?
      self.real.to_i - self.estimate.to_i
    end
  end
  
end

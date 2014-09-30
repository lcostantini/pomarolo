class Pomodoro < Ohm::Model
  attribute :description
  attribute :interruption
  attribute :estimate
  attribute :real
  attribute :finish
  attribute :date
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
    unless self.real == 0
      self.real.to_i - self.estimate.to_i
    end
  end
  
  def real_po(value)
    self.real = self.real.to_i + (value.to_i)
    self.save
  end
  
  def repeat
    if self.difference? >= 0
      self.real.to_i + 1
    else
      self.estimate.to_i
    end
  end
  
  def status_checkbox(i)
    if i < self.real.to_i
      "checked"
    else
      "unchecked"
    end
  end
  
end

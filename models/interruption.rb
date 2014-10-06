class Interruption < Ohm::Model
  attribute :description
  attribute :pomodoro
  index :pomodoro
end

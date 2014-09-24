class Interruption < Ohm::Model
  attribute :description
  attribute :pomodoro
  attribute :user
  index :pomodoro
  index :user
end

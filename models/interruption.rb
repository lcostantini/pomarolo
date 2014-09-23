class Interruption < Ohm::Model
  attribute :description
  attribute :user
  index :user
end

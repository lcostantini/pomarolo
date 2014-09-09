require "cuba"
require "mote"
require "mote/render"
require "ohm"

Cuba.plugin(Mote::Render)

Dir["./models/**/*.rb"].each { |rb| require rb }
Dir["./routes/**/*.rb"].each { |rb| require rb }

class EditPomodoro < Cuba

  attr_accessor :description, :pomarolos, :interruption, :finish

  def validate
    assert_present :description
    assert_present :pomarolos
    assert_present :interruption
    assert_present :finish
  end
  
end

Cuba.define do

  on root do
    res.write mote("views/layout.mote", title: "Pomarolo",
      content: mote("views/home.mote", pomodoros: Pomodoro.all))
  end

end

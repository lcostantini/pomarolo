require "cuba"
require "mote"
require "ohm"

Cuba.plugin Mote::Helpers

Dir["./models/**/*.rb"].each { |rb| require rb }

Cuba.define do
  
  on root do
    res.write mote("views/layout.mote",
      title: "Pomarolos",
      content: mote("views/home.mote", pomodoros: Pomodoro.all ))
  end
  
  on "add_pomodoro" do
    on param("pomodoro") do |params|
      pomodoro = Pomodoro.create(params)
      res.write mote("views/layout.mote",
        title: "New pomarolo added",
        content: mote("views/done.mote",
          restaurant_id: "",
          message: "New pomarolo added.",
          url: "/",
          button_message: "Back to pomarolos list"))
    end
    on default do
      edit = EditPomodoro.new({})
      res.write mote("views/layout.mote",
        title: "Add pomarolo",
        content: mote("views/add_pomodoro.mote",
          edit: edit))
    end
  end
  
  on "pomarolo/:pomodoro_id" do |pomodoro_id|
    pomodoro = Pomodoro[pomodoro_id]
    if pomodoro.finish == 'true'
      pomodoro.finish = false
    else
      pomodoro.finish = true
    end
    pomodoro.save
    res.write mote("views/layout.mote",
      title: "Pomarolos",
      content: mote("views/home.mote", pomodoros: Pomodoro.all ))
  end
  
end

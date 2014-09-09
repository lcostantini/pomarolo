Cuba.define do
  on "new_pomodoro" do
    on param("pomodoro") do |params|
      edit = EditPomodoro.new(params)
      pomodoro = Pomodoro.create(edit.attributes)
      res.write mote("views/layout.mote",
        title: "New pomodoro added",
        content: mote("views/done.mote",
          activity_id: "", message: "New pomodoro added.", url: "/",
          button_message: "Back to pomodoro list"))
    end

    on default do
      edit = EditPomodoro.new({})
      res.write mote("views/layout.mote",
        title: "Add pomodoro",
        content: mote("views/new_pomodoro.mote", edit: edit))
    end
  end
end

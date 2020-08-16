
# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              department: "フリーランス部",
              password_confirmation: "password",
              employee_number: 1,
              uid: 1,
              basic_time: Time.current.change(hour: 8, min: 0, sec: 0),
              admin: true
            )
User.create!( name: "上長A",
              email: "superiorA@email.com",
              password: "password",
              password_confirmation: "password",
              department: "フリーランス部",
              employee_number: 2,
              uid: 2,
              basic_time: Time.current.change(hour: 8, min: 0, sec: 0),
              admin: false,
              superiorA: true
            )
User.create!( name: "上長B",
              email: "superiorB@email.com",
              password: "password",
              password_confirmation: "password",
              department: "フリーランス部",
              employee_number: 3,
              uid: 3,
              basic_time: Time.current.change(hour: 8, min: 0, sec: 0),
              admin: false,
              superiorB: true
            )
User.create!( name: "上長C",
              email: "superiorC@email.com",
              password: "password",
              password_confirmation: "password",
              department: "フリーランス部",
              employee_number: 4,
              uid: 4,
              basic_time: Time.current.change(hour: 8, min: 0, sec: 0),
              admin: false,
              superiorC: true
            )
User.create!( name: "一般A",
              email: "generalA@email.com",
              password: "password",
              password_confirmation: "password",
              department: "フリーランス部",
              employee_number: 5,
              uid: 5,
              basic_time: Time.current.change(hour: 8, min: 0, sec: 0),
              admin: false,
              generalA: true
            )
User.create!( name: "一般B",
              email: "generalB@email.com",
              password: "password",
              password_confirmation: "password",
              department: "フリーランス部",
              employee_number: 6,
              uid: 6,
              basic_time: Time.current.change(hour: 8, min: 0, sec: 0),
              admin: false,
              generalB: true
            )

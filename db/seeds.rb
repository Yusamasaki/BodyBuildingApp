
# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true,
              employee_number: 1
            )
User.create!( name: "上長A",
              email: "superiorA@email.com",
              password: "password",
              password_confirmation: "password",
              admin: false,
              employee_number: 2
            )
User.create!( name: "上長B",
              email: "superiorB@email.com",
              password: "password",
              password_confirmation: "password",
              admin: false,
              employee_number: 3
            )
User.create!( name: "上長C",
              email: "superiorC@email.com",
              password: "password",
              password_confirmation: "password",
              admin: false,
              employee_number: 4
            )
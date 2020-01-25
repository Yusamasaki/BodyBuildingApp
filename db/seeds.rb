
# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true
            )
User.create!( name: "上長A",
              email: "superiorA@email.com",
              password: "password",
              password_confirmation: "password",
              admin: false
            )
User.create!( name: "上長B",
              email: "superiorB@email.com",
              password: "password",
              password_confirmation: "password",
              admin: false
            )
User.create!( name: "上長C",
              email: "superiorC@email.com",
              password: "password",
              password_confirmation: "password",
              admin: false
            )
User.create!( name: "User",
              email: "user@email.com",
              password: "password",
              password_confirmation: "password"
            )
User.create!( name: "User2",
              email: "user2@email.com",
              password: "password",
              password_confirmation: "password"
            )

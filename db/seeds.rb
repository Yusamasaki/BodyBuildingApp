
# coding: utf-8

User.create!( name: "遊佐 正樹",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true
            )
User.create!( name: "伊達 勇気",
              email: "sample1@email.com",
              password: "password",
              password_confirmation: "password",
              admin: false
            )
            
Bodypart.create!(
                [
                { body_part: "胸" }, { body_part: "背中" }, { body_part: "脚" }, 
                { body_part: "肩" }, { body_part: "腕" }, { body_part: "腹筋" } 
                ]
                )


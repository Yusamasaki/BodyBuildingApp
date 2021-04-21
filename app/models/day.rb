class Day < ApplicationRecord
  belongs_to :user
  has_many :workouts, dependent: :destroy
  has_many :body_weights, dependent: :destroy
end

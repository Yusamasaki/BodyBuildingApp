class Base < ApplicationRecord
  validates :basenumber, presence: true
  validates :basename, presence: true
  validates :baseinfo, presence: true
end

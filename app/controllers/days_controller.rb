class DaysController < ApplicationController

  before_action :logged_in_user, only: [:index]
  before_action :user_id_set, only: [:index]
  before_action :work_day, only: [:index]
  
  def index
  end
  
end

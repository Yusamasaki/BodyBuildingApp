class StaticPagesController < ApplicationController
  def top
    @user = User.find_by(params[:id])
  end
end

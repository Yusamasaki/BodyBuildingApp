class TraningMenusController < ApplicationController
      
  def index
    @user = User.find(params[:user_id])
    @traning_menus = @user.traning_menus.where(body_part: params[:body_part])
  end
  
  def new
    @user = User.find(params[:user_id])
    @traning_menu = @user.traning_menus.new
  end
  
  def create
    @user = User.find(params[:user_id])
    
    @traning_menu = @user.traning_menus.new(traning_menu_params)
    if @traning_menu.save
      flash[:success] = "トレーニング種目を新規追加しました。"
      redirect_to user_traning_menus_url(@user, day_id: params[:day_id], body_part: params[:body_part])
    else
      flash[:danger] = "トレーニング種目の追加に失敗しました。"
      redirect_to user_traning_menus_url(@user, day_id: params[:day_id], body_part: params[:body_part])
    end
  end
  
  
  def edit
    @user = User.find(params[:user_id])
    @traning_menu = @user.traning_menus.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @traning_menu = @user.traning_menus.find(params[:id])
    if @traning_menu.update_attributes(traning_menu_params)
      flash[:success] = "トレーニング種目を更新しました。"
      redirect_to user_traning_menus_url(@user, day_id: params[:day_id], body_part: params[:body_part])
    else
      flash[:danger] = "更新に失敗しました。"
      render :edit      
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @traning_menu = @user.traning_menus.find(params[:id])
    @traning_menu.destroy
    flash[:success] = "削除しました。"
    redirect_to user_traning_menus_url(@user, day_id: params[:day_id], body_part: params[:body_part])
  end
  
  private
    
    def traning_menu_params
      params.require(:traning_menu).permit(:traning_event, :body_part)
    end
  
end

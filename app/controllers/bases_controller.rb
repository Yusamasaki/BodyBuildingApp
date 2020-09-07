class BasesController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit_base, :update_base, :new, :create, :destroy]
  before_action :correct_user, only: [:show, :edit_base, :update_base, :new, :create, :destroy]
  before_action :admin_user, only: [:show, :edit_base, :update_base, :new, :create, :destroy]
  
  def show
    @bases = Base.all
  end
  
  def edit_base
    @base = Base.find(params[:id])
  end
  
  def update_base
    @base = Base.find(params[:id])
    if @base.update_attributes(base_params)
      flash[:success] = "拠点情報を更新しました。"
      redirect_to @base
    else
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました"
      render :edit
    end
  end
  
  def new
    @base = Base.new
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点を追加しました。"
      redirect_to bases_url
    else
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました"
      redirect_to bases_url
    end
  end
  
  def destroy
    @base = Base.find(params[:id])
    @base.destroy
    flash[:success] = "#{@base.basename}のデータを削除しました。"
    redirect_to bases_url
  end
  
  private
  
    def base_params
      params.require(:base).permit(:basename, :basenumber, :baseinfo)
    end
end

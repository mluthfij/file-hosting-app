class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :show_public, only: [:show]
  before_action :set_params, only: [:create, :destroy, :show]
  # before_action :set_params, only: [:create, :destroy, :show]

  def create
    @item = @repo.items.new(params_item)
    if @item.save
      flash[:notice] = 'Item saved.'
      redirect_to request.referrer
    else
      flash[:notice] = @item.errors.full_messages.to_sentence
      redirect_to repos_path
    end
  end

  def destroy
    @item = @repo.items.find(params[:id])
    if @item.destroy
      flash[:notice] = 'Item destroyed.'
      if @item.repo.nil?
        redirect_to request.referrer
      else
        redirect_to repo_path(@repo)
      end
    else
      flash[:notice] = @item.errors.full_messages.to_sentence
      redirect_to request.referrer
    end
  end

  def show
    @item = @repo.items.find(params[:id])
  end

  def show_public
    @repo = Repo.find(params[:repo_id])
    redirect_to repos_path, notice: "This repo is private!" if @repo.private_role == true unless current_user.id == @repo.user_id
  end
  
  private
  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    redirect_to request.referrer, notice: "Not authorized to edit this item" if @item.nil?
  end

  def set_params
    @repo = Repo.find(params[:repo_id])
  end

  def params_item
    # params[:item].permit(:name, :posts, :folder_id)
    params
    .require(:item)
    .permit(:posts, :folder_id, :user_id)
    .merge(repo_id: params[:repo_id])
  end
end

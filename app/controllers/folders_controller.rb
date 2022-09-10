class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :show_public, only: [:show]
  before_action :set_params, only: [:create, :destroy, :show]
    
  def create
    @folder = @repo.folders.new(params_folder)
    if @folder.save
      flash[:notice] = 'Folder saved.'
      redirect_to request.referrer
    else
      flash[:notice] = @folder.errors.full_messages.to_sentence
      redirect_to repos_path
    end
  end

  def destroy
    @folder = @repo.folders.find(params[:id])
    if @folder.destroy
      flash[:notice] = 'Item destroyed.'
      if @folder.repo.nil?
        redirect_to request.referrer
      else
        redirect_to repo_path(@repo)
      end
    else
      flash[:notice] = @folder.errors.full_messages.to_sentence
      redirect_to request.referrer
    end
  end

  def show
    @folder = @repo.folders.find(params[:id])
  end

  def show_public
    @repo = Repo.find(params[:repo_id])
    redirect_to repos_path, notice: "This repo is private!" if @repo.private_role == true unless current_user.id == @repo.user_id
  end

  private
  def correct_user
    @folder = current_user.folders.find_by(id: params[:id])
    redirect_to request.referrer, notice: "Not authorized to edit this folder" if @folder.nil?
  end

  def set_params
    @repo = Repo.find(params[:repo_id])
  end
  
  
  def params_folder
    params[:folder].permit(:name, :parent_id, :user_id)
  end
end

class ReposController < ApplicationController
  before_action :authenticate_user!
  before_action :set_repo, only: %i[ show edit update destroy private_fiture show_public ]
  before_action :correct_user, only: [:edit, :update, :destroy, :private_fiture]
  before_action :show_public, only: [:show]
  
  # GET /repos or /repos.json
  def index
    @q = Repo.ransack(params[:q])
    @repos = @q.result.page params[:page]
  end

  # GET /repos/1 or /repos/1.json
  def show
  end

  # GET /repos/new
  def new
    @repo = current_user.repos.build
    # @repo = Repo.new
  end

  # GET /repos/1/edit
  def edit
  end

  # POST /repos or /repos.json
  def create
    @repo = current_user.repos.build(repo_params)

    respond_to do |format|
      if @repo.save
        format.html { redirect_to repo_url(@repo), notice: "Repo was successfully created." }
        format.json { render :show, status: :created, location: @repo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repos/1 or /repos/1.json
  def update
    respond_to do |format|
      if @repo.update(repo_params)
        format.html { redirect_to repo_url(@repo), notice: "Repo was successfully updated." }
        format.json { render :show, status: :ok, location: @repo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repos/1 or /repos/1.json
  def destroy
    if @repo.destroy
      respond_to do |format|
        format.html { redirect_to repos_url, notice: "Repo was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end
  
  def private_fiture
    if @repo.private_role == true
      @repo.update_attribute(:private_role, false)
    elsif @repo.private_role == false
      @repo.update_attribute(:private_role, true)
    end
    redirect_to request.referrer
  end

  private
    def show_public
      redirect_to repos_path, notice: "This repo is private!" if @repo.private_role == true unless current_user.id == @repo.user_id
    end

    def correct_user
      # @repo = current_user.repos.find_by(id: params[:id])
      # @repo = current_user.repos.find_by_id(params[:id])
      @repo = current_user.repos.find_by_slug(params[:id])
      redirect_to repos_path, notice: "Not authorized to edit this repo" if @repo.nil?
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_repo
      @repo = Repo.find(params[:id]) rescue not_found
      # @repo = Repo.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repo_params
      params.require(:repo).permit(:name, :user_id, :slug)
    end
end

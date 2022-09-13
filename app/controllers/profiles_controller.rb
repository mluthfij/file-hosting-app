class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  def show
    @q = @profile.repos.ransack(params[:q])
    @repos = @q.result.page params[:page]
  end

  private
  def set_profile
    @profile = User.find(params[:id]) rescue not_found  
  end
end

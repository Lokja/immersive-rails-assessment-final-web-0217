class AppearancesController < ApplicationController
  before_action :find_appearance, only: [:show, :edit, :update]
  before_action :verify_login, only: [:new, :create, :edit, :update]
  after_filter :last_link, only: [:new, :create, :edit, :update]

  def index
    @appearances = Appearance.all
  end

  def show
  end

  def new
    @appearance = Appearance.new
  end

  def create
    @appearance = Appearance.new(appearance_params)
    if @appearance.save
      redirect_to @appearance.episode
    else
      redirect_to new_appearance_path
    end
  end

  def edit
  end

  def update
    if @appearance.update(appearance_params)
      redirect_to @appearance
    else
      redirect_to edit_appearance_path(@appearance)
    end
  end

  private

  def find_appearance
    @appearance = Appearance.find(params[:id])
  end

  def appearance_params
    params.require(:appearance).permit(:guest_id, :episode_id, :rating, :user_id)
  end

  def verify_login
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_path
    end
  end

  def last_link
    session[:last_link] = URI(request.referer || '').path
  end

end

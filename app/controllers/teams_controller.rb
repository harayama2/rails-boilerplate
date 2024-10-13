class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :switch]
  before_action :require_team_admin, only: [:edit, :update, :destroy]

  def index
    @teams = current_user.teams
  end

  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    # チームを作った人はオーナーにする
    @team.owner = current_user
    # チームを作った人には管理者権限を持たせる
    @team.team_users.new(user: current_user, role: "admin")

    if @team.save
      # チームの切り替え
      session[:team_id] = @team.id

      redirect_to root_path, notice: "Team created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      redirect_to team_path(@team), notice: "Team updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy!
    session[:team_id] = current_user.teams.first.id
    redirect_to root_path, notice: "Team destroyed"
  end

  def switch
    # チームの切り替え
    session[:team_id] = @team.id

    redirect_to root_path, notice: "Team switched"
  end

  private

  def set_team
    @team = current_user.teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def require_team_admin
    unless current_team_user_admin?
      redirect_to teams_path, alert: "管理者のみアクセスできます"
    end
  end
end

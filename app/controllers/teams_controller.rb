class TeamsController < ApplicationController
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
      redirect_to team_path(@team), notice: "Team created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
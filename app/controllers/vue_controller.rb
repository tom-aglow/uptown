class VueController < ApplicationController
  protect_from_forgery with: :null_session
  layout 'vue-playground'

  def index

  end

  def projects_new
    @projects = Project.all
    @project = Project.new
  end

  def projects_create
    @project = Project.new(project_params)
    if @project.save
      render json: { message: 'Project created' }
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def skills
    render json: %w[laravel ruby PHP]
  end

  def stream_index
    render 'vue/stream'
  end

  def stream_statuses
    @statuses = Status.latest.includes(:user)
    render json: @statuses.to_json(include: { user: { only: :username } })
  end

  def stream_statuses_create

  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end

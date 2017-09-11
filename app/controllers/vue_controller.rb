class VueController < ApplicationController
  layout 'vue-playground'
  protect_from_forgery with: :null_session

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


  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end

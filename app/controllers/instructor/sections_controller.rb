class Instructor::SectionsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_authorized_for_current_course

  def new
    @section = Section.new
  end

  def create
    @section = current_course.sections.create(section_params)
    redirect_to instructor_course_path(current_course)
  end

  def edit
  end

  def update
    current_section.update_attributes(section_params)
    if current_section.valid?
      redirect_to instructor_course_path(current_course)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_section.destroy
    redirect_to instructor_course_path(current_course)
  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      flash[:alert] = 'Unauthorized User … o.O'
      redirect_to root_path
    end
  end

  helper_method :current_course, :current_section

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def current_section
    @current_section ||= Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:title)
  end
  
end

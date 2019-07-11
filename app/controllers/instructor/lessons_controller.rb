class Instructor::LessonsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_authorized_for_current_section

  def new
    @section = current_section
    @lesson = Lesson.new
  end

  def create
    @section = current_section
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(@section.course)
  end

  def edit
  end

  def update
    @section = current_section
    current_lesson.update_attributes(lesson_params)
    if current_lesson.valid?
      redirect_to instructor_course_path(@section.course)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @section = current_section
    current_lesson.destroy
    redirect_to instructor_course_path(@section.course)
  end

  private

  def require_authorized_for_current_section
    if current_section.course.user != current_user
      flash[:alert] = 'Unauthorized User … o.O'
      redirect_to root_path
    end
  end

  helper_method :current_section, :current_lesson

  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video, :image)
  end
  
end

class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: [:new, :create]
  before_action :require_authorized_for_current_lesson, only: [:edit, :update, :destroy]

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end

  def edit
  end

  def update
    current_lesson.update_attributes(lesson_params)    
    if current_lesson.valid?
      flash[:notice] = 'Lesson Updated … ✔'
      redirect_to instructor_course_path(current_section.course)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_lesson.destroy
    flash[:alert] = 'Lesson Deleted … ❌'
    redirect_to instructor_course_path(current_section.course)
  end

  private

  def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      flash[:alert] = 'Unauthorized User … ☠'
      redirect_to root_path
    end
  end

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
    params.require(:lesson).permit(:title, :subtitle, :video, :image, :row_order_position)
  end  
end

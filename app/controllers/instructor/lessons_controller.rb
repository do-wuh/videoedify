class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: [:create]
  before_action :require_authorized_for_current_lesson, only: [:update, :destroy]

  def create
    @lesson = current_section.lessons.create(lesson_params)
    redirect_back(fallback_location: root_path)
  end

  def update
    current_lesson.update_attributes(lesson_params)    
    flash[:notice] = 'Lesson Updated … ✔'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_lesson.destroy
    flash[:alert] = 'Lesson Deleted … ❌'
    redirect_back(fallback_location: root_path)
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

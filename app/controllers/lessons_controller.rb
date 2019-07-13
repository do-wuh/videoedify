class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson

  def show
  end

  private

  def require_authorized_for_current_lesson
    if (!current_user.enrolled_in?(current_lesson.section.course)) && (current_user && current_user != current_lesson.section.course.user)
      flash[:alert] = 'Please Enroll in the Course to View the Lessons … ☻'
      redirect_to course_path(current_lesson.section.course)
    end
  end

  helper_method :current_lesson

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end

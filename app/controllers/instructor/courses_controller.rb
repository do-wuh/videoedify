class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show, :update, :destroy]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @section = Section.new
    @lesson = Lesson.new    
  end

  def update
    current_course.update_attributes(course_params)
    flash[:notice] = 'Course Updated … ✔'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_course.destroy
    flash[:alert] = 'Course Deleted … ❌'
    redirect_back(fallback_location: root_path)
  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      flash[:alert] = 'Unauthorized User … ☠'
      redirect_to root_path
    end
  end

  helper_method :current_course

  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost, :image)    
  end  
end

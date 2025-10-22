module Api
  module V1
    class CoursesController < BaseController
      def index
        courses = Course.includes(:teacher, :assignments).order(:code)
        render json: courses.as_json(include: {
          teacher: { only: %i[id full_name email] },
          assignments: { only: %i[id title due_on] }
        })
      end

      def show
        course = Course.includes(:teacher, assignments: {}, students: {}).find(params[:id])
        render json: course.as_json(
          include: {
            teacher: { only: %i[id full_name email] },
            assignments: { only: %i[id title due_on instructions] },
            students: { methods: :full_name, only: %i[id email status] }
          }
        )
      end

      def create
        course = Course.new(course_params)
        if course.save
          render json: course, status: :created
        else
          render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        course = Course.find(params[:id])
        if course.update(course_params)
          render json: course
        else
          render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        course = Course.find(params[:id])
        course.destroy
        head :no_content
      end

      private

      def course_params
        params.require(:course).permit(:title, :code, :description, :teacher_id)
      end
    end
  end
end

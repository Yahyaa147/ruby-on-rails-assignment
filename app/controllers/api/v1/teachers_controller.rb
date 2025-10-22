module Api
  module V1
    class TeachersController < BaseController
      def index
        teachers = Teacher.includes(:courses).order(:full_name)
        render json: teachers.as_json(include: { courses: { only: %i[id title code] } })
      end

      def show
        teacher = Teacher.includes(:courses).find(params[:id])
        render json: teacher.as_json(include: { courses: { only: %i[id title code] } })
      end

      def create
        teacher = Teacher.new(teacher_params)
        if teacher.save
          render json: teacher, status: :created
        else
          render json: { errors: teacher.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        teacher = Teacher.find(params[:id])
        if teacher.update(teacher_params)
          render json: teacher
        else
          render json: { errors: teacher.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        teacher = Teacher.find(params[:id])
        teacher.destroy
        head :no_content
      end

      private

      def teacher_params
        params.require(:teacher).permit(:full_name, :email, :department)
      end
    end
  end
end

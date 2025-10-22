module Api
  module V1
    class StudentsController < BaseController
      def index
        students = Student.includes(:courses).order(:last_name, :first_name)
        render json: students.as_json(methods: :full_name, include: { courses: { only: %i[id title code] } })
      end

      def show
        student = Student.includes(courses: :teacher).find(params[:id])
        render json: student.as_json(
          methods: :full_name,
          include: {
            courses: {
              include: { teacher: { only: %i[id full_name email] } },
              only: %i[id title code]
            }
          }
        )
      end

      def create
        student = Student.new(student_params)
        if student.save
          render json: student, status: :created
        else
          render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        student = Student.find(params[:id])
        if student.update(student_params)
          render json: student
        else
          render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
      end

      private

      def student_params
        params.require(:student).permit(:first_name, :last_name, :email, :status)
      end
    end
  end
end

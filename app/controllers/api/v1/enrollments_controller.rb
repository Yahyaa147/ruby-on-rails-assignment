module Api
  module V1
    class EnrollmentsController < BaseController
      def index
        enrollments = scoped_enrollments.includes(:student, :course)
        render json: enrollments.as_json(include: {
          student: { methods: :full_name, only: %i[id email status] },
          course: { only: %i[id title code] }
        })
      end

      def create
        attributes = enrollment_params.to_h
        attributes["enrolled_on"] = enrollment_date(attributes["enrolled_on"])

        enrollment = Enrollment.new(attributes)
        if enrollment.save
          render json: enrollment, status: :created
        else
          render json: { errors: enrollment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        enrollment = Enrollment.find(params[:id])
        enrollment.destroy
        head :no_content
      end

      private

      def scoped_enrollments
        if params[:course_id]
          Enrollment.where(course_id: params[:course_id])
        elsif params[:student_id]
          Enrollment.where(student_id: params[:student_id])
        else
          Enrollment.all
        end
      end

      def enrollment_params
        params.require(:enrollment).permit(:student_id, :course_id, :enrolled_on)
      end

      def enrollment_date(raw_date)
        return raw_date if raw_date.present?

        Date.current
      end
    end
  end
end

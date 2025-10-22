module Api
  module V1
    class AssignmentsController < BaseController
      def index
        assignments = scoped_assignments.includes(course: :teacher).order(:due_on)
        render json: assignments.as_json(include: { course: { include: { teacher: { only: %i[id full_name] } }, only: %i[id title code] } })
      end

      def show
        assignment = Assignment.includes(course: :teacher).find(params[:id])
        render json: assignment.as_json(include: { course: { include: { teacher: { only: %i[id full_name] } }, only: %i[id title code] } })
      end

      def create
        assignment = Assignment.new(assignment_params)
        if assignment.save
          render json: assignment, status: :created
        else
          render json: { errors: assignment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        assignment = Assignment.find(params[:id])
        if assignment.update(assignment_params)
          render json: assignment
        else
          render json: { errors: assignment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        assignment = Assignment.find(params[:id])
        assignment.destroy
        head :no_content
      end

      private

      def scoped_assignments
        return Assignment.where(course_id: params[:course_id]) if params[:course_id]

        Assignment.all
      end

      def assignment_params
        params.require(:assignment).permit(:course_id, :title, :instructions, :due_on)
      end
    end
  end
end

class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates :enrolled_on, presence: true
  validates :student_id, uniqueness: { scope: :course_id }
end

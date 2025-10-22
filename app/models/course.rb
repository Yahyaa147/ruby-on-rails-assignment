class Course < ApplicationRecord
  belongs_to :teacher
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  has_many :assignments, dependent: :destroy

  validates :title, :code, presence: true
  validates :code, uniqueness: true
end

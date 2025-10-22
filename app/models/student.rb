class Student < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }

  def full_name
    "#{first_name} #{last_name}"
  end
end

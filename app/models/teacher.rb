class Teacher < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  has_many :courses, dependent: :destroy

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
end

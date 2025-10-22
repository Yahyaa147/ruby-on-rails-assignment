require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  setup do
    @teacher = Teacher.create!(full_name: "Ayse Demir", email: "ayse@example.com")
    @course = Course.create!(title: "Programming", code: "CS101", teacher: @teacher)
    @student = Student.create!(first_name: "Ali", last_name: "Yildiz", email: "ali@example.com")
  end

  test "prevents duplicate enrollments for the same student and course" do
    Enrollment.create!(student: @student, course: @course, enrolled_on: Date.current)

    duplicate = Enrollment.new(student: @student, course: @course, enrolled_on: Date.current)
    assert_not duplicate.valid?
  end

  test "requires an enrollment date" do
    enrollment = Enrollment.new(student: @student, course: @course)

    assert_not enrollment.valid?
    assert_includes enrollment.errors[:enrolled_on], "can't be blank"
  end
end

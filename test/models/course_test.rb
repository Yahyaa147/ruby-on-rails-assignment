require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "requires title and code" do
    teacher = Teacher.create!(full_name: "Ayse Demir", email: "ayse@example.com")
    course = Course.new(teacher:)

    assert_not course.valid?
    assert_includes course.errors[:title], "can't be blank"
    assert_includes course.errors[:code], "can't be blank"
  end

  test "exposes students through enrollments" do
    teacher = Teacher.create!(full_name: "Ayse Demir", email: "ayse@example.com")
    course = Course.create!(title: "Programming", code: "CS101", teacher:)
    student = Student.create!(first_name: "Ali", last_name: "Yildiz", email: "ali@example.com")

    course.enrollments.create!(student:, enrolled_on: Date.current)

    assert_equal [student], course.students.to_a
  end
end

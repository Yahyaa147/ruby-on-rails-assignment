require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  test "must belong to a course" do
    assignment = Assignment.new(title: "Task")

    assert_not assignment.valid?
    assert_includes assignment.errors[:course], "must exist"
  end

  test "requires a title" do
    teacher = Teacher.create!(full_name: "Ayse Demir", email: "ayse@example.com")
    course = Course.create!(title: "Programming", code: "CS101", teacher:)
    assignment = Assignment.new(course:, title: "")

    assert_not assignment.valid?
  end
end

require "date"

Enrollment.delete_all
Assignment.delete_all
Course.delete_all
Student.delete_all
Teacher.delete_all

teacher = Teacher.find_or_create_by!(email: "ayse.demir@example.edu") do |t|
	t.full_name = "Ayse Demir"
	t.department = "Computer Science"
end

another_teacher = Teacher.find_or_create_by!(email: "murat.kaya@example.edu") do |t|
	t.full_name = "Murat Kaya"
	t.department = "Mathematics"
end

intro_course = Course.find_or_create_by!(code: "CS101") do |course|
	course.title = "Introduction to Programming"
	course.description = "Foundational programming concepts with Ruby."
	course.teacher = teacher
end

advanced_course = Course.find_or_create_by!(code: "CS220") do |course|
	course.title = "Data Structures"
	course.description = "Explores common data structures and their applications."
	course.teacher = teacher
end

math_course = Course.find_or_create_by!(code: "MATH110") do |course|
	course.title = "Discrete Mathematics"
	course.description = "Logic, sets, and combinatorics for computer science students."
	course.teacher = another_teacher
end

students = [
	{ first_name: "Ali", last_name: "Yildiz", email: "ali.yildiz@example.edu" },
	{ first_name: "Elif", last_name: "Sahin", email: "elif.sahin@example.edu" },
	{ first_name: "Can", last_name: "Aydin", email: "can.aydin@example.edu" }
]

students.each do |attrs|
	Student.find_or_create_by!(email: attrs[:email]) do |student|
		student.first_name = attrs[:first_name]
		student.last_name = attrs[:last_name]
	end
end

Assignment.find_or_create_by!(course: intro_course, title: "Hello Ruby") do |assignment|
	assignment.instructions = "Build a simple hello world API endpoint."
	assignment.due_on = Date.current + 7.days
end

Assignment.find_or_create_by!(course: advanced_course, title: "Linked Lists") do |assignment|
	assignment.instructions = "Implement a singly linked list with Ruby."
	assignment.due_on = Date.current + 14.days
end

Assignment.find_or_create_by!(course: math_course, title: "Combinatorics Worksheet") do |assignment|
	assignment.instructions = "Solve the provided counting problems."
	assignment.due_on = Date.current + 10.days
end

Student.find_by!(email: "ali.yildiz@example.edu").tap do |student|
	Enrollment.find_or_create_by!(student:, course: intro_course) do |enrollment|
		enrollment.enrolled_on = Date.current - 10.days
	end
	Enrollment.find_or_create_by!(student:, course: math_course) do |enrollment|
		enrollment.enrolled_on = Date.current - 5.days
	end
end

Student.find_by!(email: "elif.sahin@example.edu").tap do |student|
	Enrollment.find_or_create_by!(student:, course: intro_course) do |enrollment|
		enrollment.enrolled_on = Date.current - 8.days
	end
	Enrollment.find_or_create_by!(student:, course: advanced_course) do |enrollment|
		enrollment.enrolled_on = Date.current - 3.days
	end
end

Student.find_by!(email: "can.aydin@example.edu").tap do |student|
	Enrollment.find_or_create_by!(student:, course: advanced_course) do |enrollment|
		enrollment.enrolled_on = Date.current - 2.days
	end
end

puts "Seeded #{Teacher.count} teachers, #{Student.count} students, and #{Course.count} courses."

# Odev API – Assignment Report

## Project Overview
- **Goal**: Deliver a Rails API that greets the user and demonstrates at least three interconnected models (implemented with five models to earn the extra credit).
- **Models**: `Teacher`, `Course`, `Student`, `Enrollment`, `Assignment`.
- **Hello Endpoint**: `GET /api/v1/hello` (also set as the root path) responds with the required greeting and highlights the model relationships.

## Stack
- Ruby 3.2.x
- Rails 7.1.x (API only)
- SQLite (development/test)
- Rack CORS enabled for cross-origin access

## Getting Started
1. `bundle install`
2. `bin/rails db:create db:migrate db:seed`
3. `bin/rails server`
4. Visit `http://localhost:3000/api/v1/hello`

## Domain Model
- **Teacher** has many `courses`.
- **Course** belongs to a `teacher`, has many `assignments`, and connects to `students` through `enrollments`.
- **Student** has many `courses` through `enrollments`.
- **Enrollment** joins `students` and `courses`; uniqueness constraint prevents duplicates.
- **Assignment** belongs to a `course` and carries due dates/instructions.

## Key API Endpoints
- `GET /api/v1/hello`
- `resources :teachers`
- `resources :students` (nested `enrollments#index`)
- `resources :courses` (nested `assignments#index`, `enrollments#index`)
- `resources :assignments`
- `resources :enrollments` (`index`, `create`, `destroy` with optional `course_id`/`student_id` filters)

Sample payloads are available via seeded data; see `db/seeds.rb` for context.

## Testing
- Run `bin/rails test` for model and request coverage.
- Tests verify validations, associations, and the greeting endpoint.

## Submission Checklist
- [x] API-only Rails app with five related models
- [x] Greeting endpoint
- [x] Seeds demonstrating relationships
- [x] Automated tests
- [x] Report (this README) + include your GitHub repository link when submitting to the LMS/portal

## GitHub
- Repository URL: _add your public repo link here after pushing_

# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  course_id  :integer
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Enrollment < ApplicationRecord
  # Remember, belongs_to is just a method where the first argument is
  # the name of the association, and the second argument is an options
  # hash.

  belongs_to :users,
    class_name: :User,
    foreign_key: :course_id,
    primary_key: :id

  belongs_to :courses,
    class_name: :Course,
    foreign_key: :course_id,
    primary_key: :id

    

end

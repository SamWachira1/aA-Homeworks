# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  # Remember, has_many is just a method where the first argument is
  # the name of the association, and the second argument is an options
  # hash.

  has_many :enrollments,
    class_name: :Enrollment,
    foreign_key: :course_id,
    primary_key: :id

  has_many :enrolled_courses,
    through: :enrollments,
    source: :courses


end

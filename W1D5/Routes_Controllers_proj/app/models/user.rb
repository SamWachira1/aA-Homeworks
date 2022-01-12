# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ActiveRecord::Base 
    # attr_accessor :name, :email
    validates :name, presence: true 
    validates :email , presence: true, uniqueness: true

end

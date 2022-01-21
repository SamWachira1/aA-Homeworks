# == Schema Information
#
# Table name: cats
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cat < ActiveRecord::Base 
    validates :name, :skill,  presence: true
    

    has_many :toys,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Toy

end

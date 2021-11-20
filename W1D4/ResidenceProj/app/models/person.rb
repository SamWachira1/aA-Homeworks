# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  house_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Person < ApplicationRecord

    belongs_to(:houses, {
        primary_key: :id,
        foreign_key: :house_id,
        class_name: :House
    })


end

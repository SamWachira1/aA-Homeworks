# == Schema Information
#
# Table name: houses
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class House < ApplicationRecord
    has_many(:people, {
        primary_key: :id,
        foreign_key: :house_id,
        class_name: :Person
    })

end

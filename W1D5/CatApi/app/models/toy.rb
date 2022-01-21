# == Schema Information
#
# Table name: toys
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  name       :string           not null
#  ttype      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Toy < ActiveRecord::Base  
    TYPES = [
        "string",
        "ball",
        "mouse"
    ]

    # validates :cat_id, :name, :ttype, presence: true 
    validates :name, presence: true 
    validates :ttype, inclusion: TYPES  

    belongs_to :cat, 
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat
end

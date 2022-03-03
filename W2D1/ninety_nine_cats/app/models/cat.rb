# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birthdate   :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'

class Cat < ApplicationRecord 
    include ActionView::Helpers::DateHelper
    CAT_COLORS = %w(black white orange brown).freeze

    validates :birthdate, :color, :name, :sex, presence: true
    validates :color, inclusion: CAT_COLORS
    validates :sex, inclusion: %w(M F)

    has_many :rental_requests,
        class_name: :CatRentalRequest,
        dependent: :destroy


    def age 
        time_ago_in_words(birthdate)
    end


end
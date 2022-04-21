# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  band_id    :integer          not null
#  year       :integer          not null
#  live       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null


class Album < ApplicationRecord 
    belongs_to :band 

    validates :band, :title, :year, presence: true 
    validates :live, inclusion: {in: [true, false]}
    validates :title, uniqueness: {scope: :band_id}
    validates :year, numericality: {less_than: 2008, greater_than: 1900}

    after_initialize :set_defaults

    def set_defaults 
        self.live ||= false 
    end


end

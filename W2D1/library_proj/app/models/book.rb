class Book < ApplicationRecord 

    validates :title, :author, presence: true 
    validate :year_not_in_future

    def year_not_in_future
        errors[:year] << "cannot be in future" unless year < 2022 
    end

end

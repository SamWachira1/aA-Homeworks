# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
    CAT_STATUS = %w(APPROVED DENIED PENDING).freeze
    validates :cat_id, :start_date, :end_date, :status, presence: true 
    validates :status, inclusion: CAT_STATUS
    validate  :start_must_come_before_end
    validate  :does_not_overlap_approved_request

    belongs_to :cat

    after_initialize :assign_pending_status

    def approve!
        raise 'not pending' unless self.status == 'PENDING'
           transaction do
            self.status = 'APPROVED'
            self.save!

            # when we approve this request, we reject all other overlapping
            # requests for this cat.
            overlapping_pending_requests.each do |req|
                req.update!(status: 'DENIED')
            end
        end
    end


    def deny!
        self.status = "DENIED"
        self.save
    end

    def approved?
        self.status == "APPROVED"
    end

    def pending?
        self.status == "PENDING"
    end

    def denied? 
        self.status == 'DENIED'
    end

    private 
     def assign_pending_status
        self.status ||= 'PENDING'
     end

    def overlapping_requests
    CatRentalRequest
        .where.not(id: self.id)
        .where(cat_id: cat_id)
        .where.not('start_date > :end_date OR end_date < :start_date',
                    start_date: start_date, end_date: end_date)
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: 'APPROVED')
    end

    def overlapping_pending_requests
        overlapping_requests.where(status: 'PENDING')
    end


    def does_not_overlap_approved_request
        return if self.denied?

          unless overlapping_approved_requests.empty?
            errors[:id] << 'Request conflicts with existing approved request'
          end

    end

      
    def start_must_come_before_end
        return if start_date < end_date
        errors[:start_date] << 'must come before end date'
        errors[:end_date] << 'must come after start date'
    end







end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email_address   :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord 

    validates :email_address, presence: true,  uniqueness: true 
    validates :password_digest, presence: true 
    validates :session_token, presence: true, uniqueness: true 
    validates :password, length: {minimum: 6, allow_nil: true }

    attr_reader :password

    after_initialize :ensure_session_token

    def self.find_by_credentials(email_address, password)
        user = User.find_by(email_address: email_address)
        return nil if user.nil?

        user.is_password?(password) ? user : nil 
    end

   
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    # def self.generate_session_token 
    #    self.session_token = SecureRandom.urlsafe_base64(16)
    # end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64(16)
        self.save!
        self.session_token
    end

    def ensure_session_token 
        self.session_token ||= SecureRandom.urlsafe_base64(16)
    end

    








end

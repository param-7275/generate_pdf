class User < ApplicationRecord
  has_many :user_contacts, dependent: :destroy
  has_many :questions , dependent: :destroy
  has_secure_password 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true ,
   uniqueness: { case_sensitive: false },
    length: { maximum: 105 },
    format: { with: VALID_EMAIL_REGEX }
  validate :passwords_match
  validates :username, presence: true ,uniqueness: :true
  validates :password, presence: true ,confirmation: { case_sensitive: true } , length: { minimum: 8 }
  validate :password_complexity
  validates_confirmation_of :password

  def generate_password_reset_token
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.now
    save!(validate: false)
  end

  def reset_password!(new_password)
    self.password_reset_token = nil
    self.password_reset_sent_at = nil
    self.password = new_password
    save!
  end
  
  private
  def password_complexity
    return unless password
  
    unless password.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+\z/)
      errors.add(:password, "must include at least one lowercase letter, one uppercase letter, one digit, and one special character")
    end
  end


  def passwords_match
    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:password, "and password confirmation must match")
    end
  end
end


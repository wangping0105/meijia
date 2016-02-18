class User < ActiveRecord::Base
  before_create :generate_authentication_token
  has_secure_password

  acts_as_paranoid

  validates_uniqueness_of :email, conditions: -> { paranoia_scope }, allow_nil: true, allow_blank: true

  TEAVHER_URL = "/assets/guest.jpg"

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(64)
      break if !User.find_by(authentication_token: authentication_token)
    end
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def admin?
    if self.admin
      return true
    end
    false
  end

  def update_authentication_token
    generate_authentication_token
    self.save!
  end

  def self.new_authentication_token
    SecureRandom.urlsafe_base64
  end

  class << self
    def default_avatar_url(specify_gender = nil)
      assets_path = "#{APP_CONFIG[:cross_sites]['crm_base']['host']}/assets"

      if GENDERS.keys.include? specify_gender.to_s
        "#{assets_path}/#{specify_gender}.jpg"
      else
        "#{assets_path}/male.jpg"
      end
    end

    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        paranoia_scope.where(conditions).where(["lower(phone) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        paranoia_scope.where(conditions).first
      end
    end

    def with_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        paranoia_scope.where(conditions).where(["lower(phone) = :value OR lower(email) = :value", { :value => login.downcase }])
      else
        paranoia_scope.where(conditions)
      end
    end
  end
  private
  def create_authentication_token
    self.authentication_token = User.encrypt(User.new_authentication_token)
    #self.avatar_url = TEAVHER_URL
    #self.status = 0
  end
end

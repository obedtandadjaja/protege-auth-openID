class Account < ActiveRecord::Base
  has_one :facebook, class_name: 'Connect::Facebook'
  has_one :google,   class_name: 'Connect::Google'
  has_one :fake,     class_name: 'Connect::Fake'
  has_many :clients
  has_many :access_tokens
  has_many :authorizations
  has_many :id_tokens
  has_many :pairwise_pseudonymous_identifiers

  before_validation :setup, on: :create

  validates :identifier, presence: true, uniqueness: true

  has_secure_password

  validates :password, :presence => true,
      :confirmation => true,
      :length => {:within => 6..40},
      :if => :password
  validates :email, :presence => true, :uniqueness => true

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    AccountMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Account.exists?(column => self[column])
  end

  def to_response_object(access_token)
    userinfo = (google || facebook || fake).userinfo
    unless access_token.accessible?(Scope::PROFILE)
      userinfo.all_attributes.each do |attribute|
        userinfo.send("#{attribute}=", nil) unless access_token.accessible?(attribute)
      end
    end
    userinfo.email        = nil unless access_token.accessible?(Scope::EMAIL)   || access_token.accessible?(:email)
    userinfo.address      = nil unless access_token.accessible?(Scope::ADDRESS) || access_token.accessible?(:address)
    userinfo.phone_number = nil unless access_token.accessible?(Scope::PHONE)   || access_token.accessible?(:phone)
    userinfo.subject = if access_token.client.ppid?
      PairwisePseudonymousIdentifier.find_or_create_by_sector_identifier(access_token.client.sector_identifier).identifier
    else
      identifier
    end
    userinfo
  end

  private

  def setup
    self.identifier = SecureRandom.hex(8)
  end

end
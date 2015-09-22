class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :name, type: String
  field :email, type: String
  field :password_hash, type: String
  field :token, type: String, default: -> { SecureRandom.uuid }

  field :about, type: String
  field :twitter, type: String
  field :status, type: Boolean, default: false

  before_save :encrypt_password

  has_many :videos

  validates_presence_of :name, :email, :password, :token, :about
  validates_uniqueness_of :email
  validates_format_of :email,
                  with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def self.validate_token(token)
    user = User.where(token: token).first
    user ? user : false
  end

  # #TODO:0 refactor this methid
  def self.login(email, password)
    user = User.where(email: email, status: true).first
    if user
      if user.password == password
        user
      else
        false
      end
    else
      false
    end
  end

  # #FIXME:0 refactor this methid
  def self.generate_new_token(id)
    user = User.find(id)
    if user
      user.token = SecureRandom.uuid
      user.save
    else
      false
    end
  end

  protected

  def encrypt_password
    self.password_hash = Password.create(@password)
  end
end

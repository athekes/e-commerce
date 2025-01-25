class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  validates :cpf, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_one :cart, dependent: :destroy

  attr_writer :login

  # override devise authentication methods to allow login with cpf or email
  def login
    @login || self.cpf || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["cpf = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:cpf) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end

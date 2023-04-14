class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヴー]+\z/u }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヴー]+\z/u }
  validates :birth_date, presence: true
  validates :nickname, presence: true
end

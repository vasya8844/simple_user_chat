class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :messages, dependent: :delete_all

  validates_presence_of :name

  scope :active, -> { where('type IS NULL').where(is_blocked: false) }
end

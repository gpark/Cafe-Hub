class User < ActiveRecord::Base
  has_many :preferences
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessor :sign_up_code
  validates :sign_up_code,
    on: :create,
    presence: true,
    inclusion: { in: ["1234"] }
end

class User < ApplicationRecord

  enum role: [:user, :editor, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :tovars
  has_many :carts
  has_many :categories
  has_many :colors
  has_many :ed_izms
  has_many :images
  has_many :line_items
  has_many :manufacturers
  has_many :orders
  has_many :razmers
  has_many :shoppings
  has_many :tovar_razmers


  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

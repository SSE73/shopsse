class Color < ApplicationRecord

  has_many :tovar_razmers
  # has_many :tovars, through: :tovar_razmers
  # belongs_to :product, touch: true

  has_many :line_items

  has_many :images, :as => :imageable, dependent: :destroy
  belongs_to :tovar, touch: true

  # accepts_nested_attributes_for :images, update_only: true, allow_destroy: true
  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

  # validates :name, uniqueness: true, presence: true

  belongs_to :user

  def thumbnail_in_focus(size)
    images.first.photo.url(size)
  end

  def set_published
    if tovar_razmers.exists?
      update_attributes(published: true)
    else
      update_attributes(published: false)
    end
    true
  end

end

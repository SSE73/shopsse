class Tovar < ApplicationRecord

  belongs_to :ed_izm
  belongs_to :manufacturer
  belongs_to :category

  has_many :shoppings


  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  has_many :tovar_razmers
  has_many :razmers, through: :tovar_razmers

  has_many :colors  #SSE, through: :tovar_razmers

  belongs_to :user

  validates :title, uniqueness: true, presence: true

  attr_reader :razmer_tokens

  def razmer_tokens=(tokens)
    self.razmer_ids = Razmer.ids_from_tokens(tokens)
  end

#  has_attached_file :photo
#  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
#  has_attached_file :photo, :styles => { :small => "150x150>" },
#                    :url  => "/assets/tovars/:id/:style/:basename.:extension",
#                    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
  
#  validates_attachment_presence :photo
#  validates_attachment_size :photo, :less_than => 5.megabytes
#  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

 #SSE  validates :photo,
 #SSE    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
 #SSE    attachment_size: { less_than: 5.megabytes }
 #SSE
 #SSE  has_attached_file :photo, styles: {
 #SSE    cartphoto: '90x120>',
 #SSE    realphoto: '300x400>',
 #SSE    prosmphoto: '160x200>'
 #SSE },
 #SSE :url  => "/assets/tovars/:id/:style/:basename.:extension",
 #SSE      :path => ":rails_root/public/assets/tovars/:id/:style/:basename.:extension"
  
  def ed_izm_name
    ed_izm.try( :name)
  end

  def ed_izm_name=(name)
    self.ed_izm = Ed_Izm.find_or_create_by_name(name) if name.present?
  end

  def ensure_not_referenced_by_any_line_item
    if line_item.empty?
      return true
    else
      errors.add(:base, 'sushesnvyut tovarnie pozizii')
      return false
    end
  end

  private
  def set_published
    if colors.published.exists?
      update_attributes(published: true)
    else
      update_attributes(published: false)
    end
    true
  end

end

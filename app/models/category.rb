class Category < ApplicationRecord
  has_many :tovars
  validates :name, uniqueness: true, presence: true

  belongs_to :user

  #def count_tovar_categ
    #Tovar.count_by_sql "SELECT COUNT(*) FROM tovars t, categories c WHERE t.category_id = c.id"
    #Tovar.count_by_sql "SELECT COUNT(*) FROM tovars t WHERE t.category_id = #{@id}"

  #end
end

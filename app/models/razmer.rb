class Razmer < ApplicationRecord

  has_many :tovar_razmers
  has_many :tovars, through: :tovar_razmers

  #SSE has_many :line_items

  validates :name, uniqueness: true, presence: true

  # def self.tokens(query)
  #   razmers = where("name like ?", "%#{query}%")
  #   if razmers.empty?
  #     [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
  #   else
  #     razmers
  #   end
  # end
  #
  # def self.ids_from_tokens(tokens)
  #   tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
  #   tokens.split(',')
  # end

end

class TovarRazmer < ApplicationRecord

  belongs_to :tovar
  belongs_to :razmer

  # belongs_to :color
  belongs_to :color, touch: true

  # has_many :images, as: :imageable, dependent: :destroy

  validates_uniqueness_of :razmer_id, scope: [:tovar_id, :color_id]


  # Или даже несколько параметров области видимости.
  # Например, убедившись в том, что учитель может быть только по графику один раз в семестр для конкретного класса.

  # class TeacherSchedule < ActiveRecord::Base
  #   validates_uniqueness_of :teacher_id, scope: [:semester_id, :class_id]
  # end

  # Кроме того, можно ограничить ограничение уникальности для набора записей, соответствующих определенным условиям.
  # В этом примере архивные статьи не принимаются во внимание при проверке уникальности атрибута заголовка:

  # class Article < ActiveRecord::Base
  #   validates_uniqueness_of :title, conditions: -> { where.not(status: 'archived') }
  # end

  # Когда создается запись, выполняется проверка, чтобы убедиться,
  # что ни одна запись не существует в базе данных с заданным значением для указанного атрибута
  # (который отображает на колонку). Когда запись обновляется, то же проверка, но не обращая внимания на саму запись.



  # validates_numericality_of :price

  # attr_reader :price_modification
  #
  # def price_modification=(new_price)
  #   @price_modification = new_price
  #   if new_price.to_s.ends_with? "%"
  #     self.price += (price * (new_price.to_d/100)).round(2)
  #   else
  #     self.price = new_price
  #   end
  # end


end

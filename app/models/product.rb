class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  has_many :variants
 # has_many :orders, through: :order_items

  def visible_on_catalog?
    self.variant.each do |variant|
      if variant.stock > 0
        return true
      end
      false
    end
  end
end

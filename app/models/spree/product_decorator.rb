Spree::Product.class_eval do
  has_many :videos, as: :watchable
end
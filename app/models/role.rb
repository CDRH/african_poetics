class Role < ApplicationRecord

  has_many :news_item_roles
  has_many :work_roles

end

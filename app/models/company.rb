class Company < ApplicationRecord
  validates :email, format: { with: /[a-z0-9](\.?[a-z0-9]){5,}@getmainstreet\.com/, message: "Only @getmainstree.com emails allowed" }, allow_blank: true
  has_rich_text :description
end

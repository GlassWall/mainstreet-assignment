class Company < ApplicationRecord
  validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@getmainstreet.com\>*\Z)/, message: "should end with @getmainstreet.com" }, allow_blank: true
  has_rich_text :description
end

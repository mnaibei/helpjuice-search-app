class Log < ApplicationRecord
  validates :query, presence: true
  validates :ip_address, presence: true

  scope :search_by_title, ->(query) { where('query ILIKE ?', "%#{query}%") }

end

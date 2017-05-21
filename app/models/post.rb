class Post < ApplicationRecord
  scope :featured_posts, lambda {
                                  includes(:categories)
                                    .order('created_at DESC')
                                    .limit(10)
                                }
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, :description, :expiration_date, presence: true

  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    return unless expiration_date && expiration_date < Date.today
    errors.add(:expiration_date, 'cant be in the past!')
  end
end

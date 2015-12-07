class Message < ActiveRecord::Base
  validates :user_id, :messageable_id, :messageable_type, presence: true
  validates :money, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :messageable, polymorphic: true
end

class Message < ActiveRecord::Base
  validates :sender_id, :messageable_id, :messageable_type, presence: true
  validates :money, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :sender, class: User, foreign_key: "sender_id"
  belongs_to :parent_message, class: Message, foreign_key: "parent_message_id"
  belongs_to :messageable, polymorphic: true

  has_many :child_messages, class: Message, foreign_key: "parent_message_id"
end

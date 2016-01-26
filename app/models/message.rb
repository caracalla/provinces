class Message < ActiveRecord::Base
  validates :sender_id, :messageable_id, :messageable_type, :body, presence: true
  validates :money, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :sender, class_name: User, foreign_key: "sender_id"
  belongs_to :parent_message, class_name: Message, foreign_key: "parent_message_id"
  belongs_to :messageable, polymorphic: true

  has_many :child_messages, class_name: Message, foreign_key: "parent_message_id"
end

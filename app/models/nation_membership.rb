class NationMembership < ActiveRecord::Base
  validates :province_id, :nation_id, :member_title, presence: true
  validates :rank, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :province
  belongs_to :nation
end

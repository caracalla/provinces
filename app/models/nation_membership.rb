class NationMembership < ActiveRecord::Base
  MEMBERSHIP_STATES = %w(inactive active pending)

  validates :province_id, :nation_id, :member_title, presence: true
  validates :rank, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :state, presence: true, inclusion: { in: MEMBERSHIP_STATES }

  belongs_to :province
  belongs_to :nation
end

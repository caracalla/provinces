class Nation < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :nation_memberships, -> { where state: "active" }, dependent: :destroy
  has_many :provinces, through: :nation_memberships
end

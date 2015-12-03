class Nation < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :nation_memberships, -> { where state: "active" }, dependent: :destroy
  has_many :provinces, through: :nation_memberships

  has_attached_file :flag, styles: { medium: "300x300>" }, default_url: "/images/:style/default_flag.svg"
  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :flag, less_than: 1.megabytes
end

class Province < ActiveRecord::Base
  CURRENCY_NAMES = %w(dollar yen yuan pound peso ruble dong rupee euro talent)
  GOVERNMENT_TYPES = {
    "democracy" => "makes people happier, dings infra",
    "autocracy" => "makes people unhappier, boosts infra",
    "monarchy" => "makes people happier, dings tech",
    "oligarchy" => "makes people unhappier, boosts tech",
    "military junta" => "makes people unhappier, boosts military",
    "anarchy" => "makes people unhappier, dings all things"
  }
  RESOURCES = %w(timber gold iron wine coal)

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :user_title, :money, :user_id, presence: true
  validates :currency_name, presence: true, inclusion: {
    in: CURRENCY_NAMES,
    message: "%{value} is not a valid currency"
  }
  validates :government_type, presence: true, inclusion: {
    in: GOVERNMENT_TYPES.keys,
    message: "%{value} is not a valid system of governance"
    # Joke idea: add various forms of government I don't agree with to the
    # government picker, so when someone chooses it, this message is shown.
    # I'm so funny.
  }
  validates :resource_1, :resource_2, presence: true, inclusion: {
    in: RESOURCES,
    message: "%{value} is not a valid resource"
  }
  validates :population, :infrastructure, :technology, :local_tax_rate, numericality: {
    greater_than_or_equal_to: 0
  }

  has_many :pending_nation_memberships, -> { where state: "pending" }, class_name: NationMembership, dependent: :destroy
  has_one :nation_membership, -> { where state: "active" }, dependent: :destroy
  has_one :nation, through: :nation_membership

  belongs_to :user

  has_attached_file :flag, styles: { medium: "300x300>" }, default_url: "/images/:style/default_flag.svg"
  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :flag, less_than: 1.megabytes

  before_validation :set_initial_values, on: :create

  private

  def set_initial_values
    self.resource_1 = RESOURCES.sample
    self.resource_2 = RESOURCES.reject { |r| r == resource_1 }.sample
    self.population = 100
    self.money = 50000
    self.infrastructure = 0
    self.technology = 0
  end

  def has_nation?
    self.nation_membership.state == "active"
  end
end

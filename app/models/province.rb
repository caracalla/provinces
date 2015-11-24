class Province < ActiveRecord::Base
  CURRENCY_NAMES = %w(dollar yen yuan pound peso ruble dong rupee euro)
  GOVERNMENT_TYPES = %w(Democracy Autocracy Monarchy Oligarchy Anarchy)
  RESOURCES = %w(timber gold iron wine coal)

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :user_title, :money, :user_id, presence: true
  validates :currency_name, presence: true, inclusion: {
    in: CURRENCY_NAMES,
    message: "%{value} is not a valid currency"
  }
  validates :government_type, presence: true, inclusion: {
    in: GOVERNMENT_TYPES,
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
    greater_than: 0
  }

  belongs_to :user

  before_create :set_initial_values

  private

  def set_initial_values
    self.resource_1 = RESOURCES.sample
    self.resource_2 = RESOURCES.sample until resource_2 != resource_1
    self.population = 100
    self.money = 50000
    self.infrastructure = 0
    self.technology = 0
  end
end

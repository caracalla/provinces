class Province < ActiveRecord::Base
  CURRENCY_NAMES = %w(dollar yen yuan pound peso ruble dong rupee euro talent)
  GOVERNMENT_TYPES = {
    "democracy" => "for whiners",
    "autocracy" => "for manly men",
    "monarchy" => "for kingly men",
    "oligarchy" => "for rich men",
    "anarchy" => "for crazy men"
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

  belongs_to :user

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
end

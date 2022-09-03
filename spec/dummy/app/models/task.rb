class Task < ApplicationRecord
  has_many :timelogs, dependent: :destroy

  validates :name, presence: true
end

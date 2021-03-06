class Xset < ActiveRecord::Base
  belongs_to :exercise
  has_one :rep, dependent: :destroy

  validates :exercise, presence: true
end

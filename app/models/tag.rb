# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :name, format: { without: /\s/ }
end

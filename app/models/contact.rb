# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 100 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, email: { mode: :strict }
end

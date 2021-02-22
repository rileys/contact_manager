# frozen_string_literal: true

class Contact < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true, length: { minimum: 4, maximum: 100 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, email: { mode: :strict }

  scope :tagged_with, ->(tag_name) { where(id: Tagging.with_tag_name(tag_name).select(:contact_id)) }
end

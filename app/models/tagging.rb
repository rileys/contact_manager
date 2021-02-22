# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :contact
  belongs_to :tag

  validates :contact_id, uniqueness: { scope: :tag_id }

  scope :with_tag_name, ->(tag_name) { where(tag_id: Tag.where(name: tag_name)) }
end

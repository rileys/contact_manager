# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { Faker::Job.unique.title.delete(' ') }
  end
end

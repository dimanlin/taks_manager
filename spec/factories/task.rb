FactoryGirl.define do
  sequence :task_name do |n|
    "task_#{n}"
  end

  factory :task do
    name { FactoryGirl.generate(:task_name) }
    description FFaker::Lorem.paragraph
  end
end

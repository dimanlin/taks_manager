User.destroy_all

3.times do |index|
  User.create(email: "example_#{index}@gmail.com", password: 'root0000', password_confirmation: 'root0000')
end

User.all.each do |user|
  5.times do |index|
    user.tasks.create(state: User.states.keys.sample, name: "task_name_#{index}", description: FFaker::Lorem.paragraph)
  end
end

Task.create(state: User.states.keys.sample, name: "task_name_with_out_user", description: FFaker::Lorem.paragraph)
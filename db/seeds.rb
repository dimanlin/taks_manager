3.times do |index|
  User.create(email: 'example_1@gmail.com', password: 'root0000', password_confirmation: 'root0000')
end

User.all.each do |user|
  5.times do
    user.tasks.create(state: User.states.keys.sample, name: 1, description: FFaker::Lorem.paragraph)
  end
end
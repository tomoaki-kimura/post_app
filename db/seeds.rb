30.times do |n|
  User.create!(email: "test#{n + 1}@test.com", password: "password")
end
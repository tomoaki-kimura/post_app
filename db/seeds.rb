30.times do |n|
  User.create!(email: "test#{n + 1}@test.com", password: "password")
end

(1..10).each do |n|
  user = User.find(n)
  2.times do |i|
    user.pictures.create!(title: "user#{user.id}_post#{i}", description: "xxxxx" * rand(10))
  end
end
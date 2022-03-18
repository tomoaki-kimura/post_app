30.times do |n|
  User.create!(email: "test#{n + 1}@test.com", password: "password")
end

index = 0
(1..10).each do |n|
  user = User.find(n)
  2.times do |i|
    index += 1
    picture = user.pictures.create!(title: "user#{user.id}_post#{i}", description: "xxxxx" * rand(10))
    if index <= 10
      picture.picture.attach(io: File.open(Rails.root.join("db/fixture/img_#{format("%03d", index)}.jpg")),
                     filename: "img_#{format("%03d", index)}.jpg")
    end
  end
end
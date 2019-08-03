
40.times do |n|
  User.create(name: "#{n}test",email: "testexample#{n}.com",password: "111111",image_name: "default.png")
end

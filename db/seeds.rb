#four categories
['Spring', 'Summer', 'Autumn', 'Winter'].each do |category|
  Category.create(name: category)
end


10.times do
  User.create first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            password: "12345678",
            password_confirmation: "12345678",
            description: Faker::Hipster.paragraph
end

20.times do
  Post.create image: Faker::Book.title,
              #image will be replaced
              description: Faker::Hipster.sentence,
              category: Category.all.sample,
              user: User.all.sample
end

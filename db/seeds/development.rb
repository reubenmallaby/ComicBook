comic = Comic.new(
  title: "In the Beginning",
  description: "Starter comic page",
  publish_date: DateTime.new(2000,1,1),
  is_published: true
)
comic.image.attach io: File.open(Rails.root.join('db/images/default.png')), filename: "default.png"
comic.tag_list.add("funny", "art", "painting", "fave")
comic.save!

comic = Comic.new(
  title: "End of the year 2023",
  description: "Here we go!",
  publish_date: DateTime.new(2023,12,31),
  is_published: true
)
comic.image.attach io: File.open(Rails.root.join('db/images/default.png')), filename: "default.png"
comic.tag_list.add("art", "serious", "painting", "fave")
comic.save!

comic = Comic.new(
  title: "Mid fall 2023",
  description: "Yellowing leaves",
  publish_date: DateTime.new(2023,11,1),
  is_published: true
)
comic.image.attach io: File.open(Rails.root.join('db/images/default.png')), filename: "default.png"
comic.tag_list.add("art", "serious")
comic.save!

comic = Comic.new(
  title: "In the year 2024",
  description: "Latest published",
  publish_date: DateTime.new(2024,1,1),
  is_published: true
)
comic.image.attach io: File.open(Rails.root.join('db/images/default.png')), filename: "default.png"
comic.tag_list.add("funny", "fave")
comic.save!

def create_dev_user(name, admin: false)
  user = User.create(
    name: name,
    admin: admin,
    email: "#{name.downcase}@example.com",
    password: "12345678#Dev",
    password_confirmation:"12345678#Dev",
    )
  user.skip_confirmation!
  user.save!
end
%w[ArtistOne Artist2 AssistantOne].each {|name| create_dev_user(name, admin: true) }
%w[UserOne UserTwo UserThree UserFour UserFive].each { |name| create_dev_user(name) }


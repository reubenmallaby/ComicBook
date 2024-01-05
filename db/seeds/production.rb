comic = Comic.new(
  title: "In the Beginning",
  description: "Starter comic page",
  publish_date: DateTime.new(2000,1,1),
  is_published: true
)
comic.image.attach io: File.open(Rails.root.join('db/images/default.png')), filename: "default.png"
comic.save!

admin = User.create(
  name: name,
  admin: true,
  email: "#{name.downcase}@example.com",
  password: "12345678#Dev",
  password_confirmation:"12345678#Dev",
  )
admin.skip_confirmation!
admin.save!

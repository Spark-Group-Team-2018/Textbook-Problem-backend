# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dummy_manufacturer = Manufacturer.create(name: "none", description: "does not exist")

books = Book.create([
  {
   ISBN: 9780486404530,
   title: "Calculus: An Intuitive and Physical Approach (Second Edition) (Dover Books on Mathematics)",
   description: "A Calculus book",
   manufacturer_id: dummy_manufacturer.id
  },
  {
    ISBN: 9780321573513,
    title: "Algorithms (4th Edition)",
    description: "You need this for Comp Sci",
    manufacturer_id: dummy_manufacturer.id
  },
  {
    ISBN: 9781524710170,
    title: "Cracking the AP U.S. Government & Politics Exam 2018, Premium Edition (College Test Preparation)",
    description: "Useful for AP Gov",
    manufacturer_id: dummy_manufacturer.id
  }
])

user = User.create(:first_name => "Michael", :last_name => "Navazhylau", :email => "mikipux7@gmail.com")
user_2 = User.create(:first_name => "Haran", :last_name => "Kumar", :email => "danke@mail.com")

textbooks = Textbook.create([
  {
      book_id: 1,
      user_id: user.id,
      status: "meh",
      owner_description: "I like it",
      is_public: true
  },

  {
      book_id: 2,
      user_id: user_2.id,
      status: "It aight",
      owner_description: "I like it",
      is_public: true
  }

])

offers = Offer.create([
  {
    price: 20.00,
    is_public: true,
    textbook_id: 1
  },

  {
    price: 30.00,
    is_public: true,
    textbook_id: 2
  }

])

pendingoffers = PendingOffer.create([
  {
    offer_id: 1,
    buyer_id: user_2.id
  },
  {
    offer_id: 2,
    buyer_id: user.id
  }
])

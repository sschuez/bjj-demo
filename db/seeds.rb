# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

belts = ['White', 'White I', 'White II', 'White III', 'White IIII', 'Blue', 'Blue I', 'Blue II', 'Blue III', 'Blue IIII', 'Purple', 'Purple I', 'Purple II', 'Purple III', 'Purple IIII', 'Brown', 'Brown I', 'Brown II', 'Brown III', 'Brown IIII', 'Black']
categories = ['personal info', 'membership', 'promotion', 'weight', 'miscellaneous']
sex = ['male', 'female', 'undefined']

puts 'Deleting all users...'
User.destroy_all if Rails.env == "DEVELOPMENT"

puts 'Creating Admins...'
admin1 = User.create!(
  email: 'stephen.schuez@gmail.com',
  password: "777jjj",
  admin: true,
  first_name: 'Stephen',
  last_name: 'Schuez',
  date_of_birth: "Wed, 17 Aug, 1988",
  phone: '+41793173399',
  started: "Tue, 4 Feb, 2020",
  weight: 74, 														
  height: 175,
  sex: "male",																
  weight_good: true, 										
  # reasons_for_weight:	Faker::Lorem.sentence(word_count: 5),			
  active_member: true, 								
  # not_active_why:	"",							
  # belt: @belts[0],																	
  # last_promotion: "Tue, 20 Aug, 2019", 								
  )
  promotion = Promotion.new(
    belt: "White I",
    promoted_at: "Tue, 20 Aug, 2019",
    )
  promotion.user = admin1
  promotion.save

  admin2 = User.create!(
  email: 'rodrigo@test.com',
  password: "aaaaaa",
  admin: true,
  first_name: 'Rodrigo',
  last_name: 'Fernandes',
  date_of_birth: "",
  phone: '',
  started: "",
  weight: 75, 														
  height: 175,
  sex: "male",																
  weight_good: true, 										
  # reasons_for_weight:	Faker::Lorem.sentence(word_count: 5),			
  active_member: true, 								
  # not_active_why:	"",							
  # belt: @belts[0],																	
  # last_promotion: "Tue, 20 Aug, 2019", 								
  )
  promotion = Promotion.new(
    belt: "Black I",
    promoted_at: "Tue, 20 Aug, 2017",
    )
  promotion.user = admin2
  promotion.save

puts 'Creating 50 users...'
20.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'aaaaaa',
    admin: false,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.birthday(min_age: 16, max_age: 65),
    phone: Faker::PhoneNumber.phone_number_with_country_code,
    started: Faker::Date.between(from: 1000.days.ago, to: Date.today),
    weight: rand(50..100), 														
    height: rand(145..190),																
    sex: sex.sample,																
    weight_good: Faker::Boolean.boolean(true_ratio: 0.7), 										
    # reasons_for_weight:	Faker::Lorem.sentence(word_count: 5),			
    active_member: Faker::Boolean.boolean(true_ratio: 0.8), 								
    # not_active_why:	Faker::ChuckNorris.fact,							
    # belt: belts.sample,																	
    # last_promotion: Faker::Date.backward(days: 1000),
    )
  rand(1..5).times do
    comment = Comment.new(
      category: categories.sample,
      content: Faker::ChuckNorris.fact,
      )
    comment.user = user
    comment.save
  end

  promotion = Promotion.new(
    belt: belts.sample,
    promoted_at: Faker::Date.backward(days: 1000),
    )
  promotion.user = user
  promotion.save

end
puts "Created #{User.count} Users."


# SCHEMA:

#  email:																		(string)
#  encrypted_password:											(string)
#  reset_password_token:										(string)
#  reset_password_sent_at: 									(datetime)
#  remember_created_at:											(datetime)
#  created_at: 															(datetime)
#  updated_at:															(datetime)
#  admin: 																	(boolean)
#  first_name: 															(string)
#  last_name:																(string)
#  date_of_birth:														(date)	
#  phone:																		(string)
#  started:																	(date)
#  weight:  																(integer)
#  height:																	(integer)
#  weight_good: 														(boolean)
#  reasons_for_weight:											(string)
#  active_member: 													(boolean)
#  not_active_why:													(string)
#  belt:																		(string)
#  last_promotion:													(date)	





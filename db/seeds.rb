# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create!(email: 'admin@admin.ru', password: 'password')

# colors
%w(#520EAB #64A72D #8F2497 #244EAF #EB30A0).each do |code|
  Color.create!(code: code)
end

#sizes
%w(S M L XL XXL).each do |size|
  Size.create!(name: size)
end

PATH  = 'public/seed'

entries = Dir.entries(PATH) - %w(. .. DS_Store)

categories = Category.where.not(children_count: 0)

20.times do |n|
  p = Product.create!(
    name: "My New Product #{n}",
    marking: '1213131' + n.to_s,
    category_id: categories.sample.id,
    price: 10000
  )
  p.sizes << Size.all.sample([2,3].sample)
  p.colors << Color.all.sample([2,3].sample)
  entries.sample(5).each do |filename|
    p.product_attachments.create!(asset: File.open(PATH + '/' + filename))
  end


end

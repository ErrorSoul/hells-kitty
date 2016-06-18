# -*- coding: utf-8 -*-
namespace :db do
  desc 'populate products'
  task create_products: :environment do
    PATH  = 'public/photo'
    files = Dir.foreach(PATH).select do |filename|
      !filename.in?(%w(. ..))
    end

    files = files.map do |filename|
      File.join(PATH, filename)
    end
    categories = Category.where(children_count: 0)
    sizes = Size.all
    Product.transaction do
      50.times do |n|
        p = Product.create!\
          name: "Classic Modern #{n}",
          category_id: categories.sample.id,
          price: 10000,
          marking: "ABCD#{n}"
        files.each do |file|
          p_a = ProductAttachment.new
          p_a.asset = File.open(file)
          p.product_attachments << p_a
        end
        [sizes.sample, sizes.sample, sizes.sample].each do |size|
          p_s = ProductSize.new
          p_s.size_id = size.id
          p_s.value = 10
          p.product_sizes << p_s
        end
      end
    end
  end

  desc 'populate categories'
  task create_categories: :environment do
    categories_array =
      [
        ['одежда', [
          ['верхняя одежда', ['куртки', 'пальто']],
          ['платья',
           ['вечерние','коктейльные', 'миди', 'макси', 'мини', 'с принтом']
          ],
          ['юбки и шорты', %w(миди макси мини)],
          ['топы и футболки',
           ['базовые', 'с принтом',' с длинными рукавами', 'с короткими рукавами', 'без рукавов']
          ],
          ['жакеты и жилеты'],
          ['рубашки и блузки'],
          ['denim'],
          ['трикотаж',
           ['джемперы и свитера', 'кардиганы', 'свитшоты']
          ]
        ]
       ],
       ['обувь', ['кеды и кроссовки']],
       ['аксессуары',
        [
          ['украшения', %w(браслеты броши колье кольца серьги)],
          'iphone cases',
          'для дома', 'сумки',
          'аксессуары для волос',
          'солнцезащитные очки',
          'головные уборы'
        ]
       ],
       ['vintage', [ 'одежда', 'сумки', 'аксессуары']]

      ]
    Category.transaction do
      categories_array.each do |arr|
        rec_creator(arr)
      end
    end
  end
end

def rec_creator(arr, parent_id = nil)
  category = nil
  arr.each do |x|
    p x
    if x.is_a? String
      category = Category.create!(parent_id: parent_id, name: x)
    elsif x.is_a? Array
      rec_creator(x, category.try(:id) || parent_id)
    end
  end
end

# -*- coding: utf-8 -*-
namespace :db do
  desc 'populate && seeds'
  task populate: :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    Rake::Task["db:create_categories"].invoke
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

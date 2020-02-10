# This file should contain all the record creation needed
# to seed the database with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[
  ['the Creature', 'the Black Lagoon'],
  ['two turtle doves', 'Puddle'],
  ['three french hens', 'Puddle'],
  ['four calling birds', 'Puddle'],
  ['five golden rings', 'Puddle'],
  ['six geese a-laying', 'Puddle'],
  ['seven swans a-swimming', 'Puddle'],
  ['eight maids a-milking', 'Puddle'],
  ['nine ladies dancing', 'Puddle'],
  ['a comeback', 'QwerkyOne'],
  ['a nice ass-car', 'QwerkyOne'],
  ['the root password', 'QwerkyOne'],
  ['a dirty bucket', 'QwerkyOne'],
  ['a magic wand', 'QwerkyOne'],
  ['a headcrab', 'Jekotia'],
  ['42 hikers a-hitching', 'MrMKenyon'],
  ['root permissions', 'MrMKenyon'],
].each do |item|
  Item.find_or_create_by(what: item[0], placed_by: item[1])
end

[
  ['sword', 'Michael Abon'],
  ['potato', 'Michael Abon'],
].each do |noun|
  Noun.find_or_create_by(what: noun[0], placed_by: noun[1])
end

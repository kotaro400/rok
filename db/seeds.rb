# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

legend_commander_names = [
  "源義経",
  "カール・マルテル",
  "エセルフレッド",
  "曹操",
  "リチャード1世",
  "クレオパトラ7世",
  "石田三成",
  "善徳女王",
  "エル・シッド",
  "フリードリヒ1世",
  "ユリウス・カエサル",
  "メフメト2世",
  "李成桂",
  "ハンニバル・バルカ",
  "サラディン",
  "チンギス・カン",
  "コンスタンティヌス1世",
  "アレキサンダー大王",
  "エドワード",
  "トミュリス",
  "カール大帝",
  "武則天",
]

epic_commander_names = [
  "ベリサリウス",
  "孫武",
  "アルミニウス",
  "ブーディカ",
  "ロッハ",
  "楠木正成",
  "ジャンヌ・ダルク",
  "バイバルス",
  "乙支文徳",
  "マティルダ",
  "スキピオ・アフリカヌス",
  "ペラーヨ",
  "オスマン1世",
  "カイラ",
]

legend_commander_names.each_with_index do |name, i|
  Commander.create(id: i + 1, name: name, rarity: "レジェンド") unless Commander.find_by(name: name)
end

epic_commander_names.each_with_index do |name, i|
  Commander.create(id: legend_commander_names.length + i + 1, name: name, rarity: "エピック") unless Commander.find_by(name: name)
end

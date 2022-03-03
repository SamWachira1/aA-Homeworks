# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


cat1 = Cat.create(birthdate: '2016/07/13', color: 'black', name: 'Sabrina', sex: "F", description: "turns into a witch in the middle of the night beware" )
cat2 = Cat.create(birthdate: '2021/12/02', color: 'brown', name: 'Jackson', sex: "F", description: "super lazy" )
cat3 = Cat.create(birthdate: '2018/09/18', color: 'white', name: 'Garfield', sex: "M", description: "eats alot" )
cat4 = Cat.create(birthdate: '2017/04/14', color: 'orange', name: 'Puffy', sex: "M", description: "loves the mice" )


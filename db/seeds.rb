# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name:'Picture')

Category.create(name:'English')

Category.create(name:'Teaching')

Category.create(name:'Religion')

Category.create(name:'Other')

Category.create(name:'Soft Cover')

Category.create(name:'Hard Cover')

Category.create(name:'Tall')

Category.create(name:'Short')

Book.create(name:'Weapons: Helmet of Salvation', isbn:'1230000100',barcode:'P10001')


Book.create(name:'Weapons: Sword of Truth', isbn:'1230000101',barcode:'P10002')

Book.create(name:'Weapons: Breastplate of Confidence', isbn:'1230000102',barcode:'P10003')

User.create(email:'123@1.com', member_id:'201610123')
User.create(email:'123@2.com', member_id:'201610124')
User.create(email:'123@3.com', member_id:'201610125')
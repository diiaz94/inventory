# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(
				[
					{nombre: "Admin",descripcion: "Administra la aplicacion"},
					{nombre: "Owner",descripcion: "Due;o de algun comercio"},
					{nombre: "Seller",descripcion: "Vendedor de alguna tienda"}

				]
			)
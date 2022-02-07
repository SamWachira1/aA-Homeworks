# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all


sam = User.create!(username: "DayTRip95")
corey = User.create!(username: "kidCwebby96")
fod = User.create!(username: "Foderaro96")
tomp = User.create!(username: "ctommpy95")

mona = Artwork.create!(title: "The Mona Lisa", image_url: "www.monalisa.com", artist_id: sam.id)
pica = Artwork.create!(title: "The Picasso", image_url: "www.picasso.com", artist_id: corey.id)

ArtworkShare.create!(artwork_id: mona.id, viewer_id: corey.id)
ArtworkShare.create!(artwork_id: mona.id, viewer_id: fod.id)
ArtworkShare.create!(artwork_id: pica.id, viewer_id: tomp.id)

Comment.create!(body: "Dam mona lisa you is fine", user_id: sam.id, artwork_id: mona.id)







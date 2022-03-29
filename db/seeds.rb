# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "csv"

BookGenre.destroy_all
Book.destroy_all
Genre.destroy_all
#Province.destroy_all


# provinces = Rails.root.join("db/provinces.csv")
# province_data = File.read(provinces)
# province_list = CSV.parse(province_data, headers: true, encoding: "utf-8")

# province_list.each do |p|
#   new_province = Province.create(
#     name: p["name"],
#     gst:  p["gst"],
#     pst:  p["pst"],
#     hst:  p["hst"]
#     )
# end

books_csv = File.read(Rails.root.join("db/books.csv"))
books = CSV.parse(books_csv, headers: true, encoding: "utf-8")

books.each do |book|
  b = Book.create(
    name:             book["Name"],
    author:           book["Author"],
    description:      book["Description"],
    publication_year: book["PublicationYear"],
    publisher:        book["Publisher"],
    isbn:             book["ISBN"],
    price_cents:      book["Price"]
  )
  unless b.valid?
    puts "Could not create book: #{book['Name']}"
    puts b.errors.messages
  end

  genres = book["Genres"].split("; ")
  genres.each do |genre|
    g = Genre.find_or_create_by(name: genre)
    unless g.valid?
      puts "Invalid genre: #{genre} for book: #{b.name}"
      next
    end
    BookGenre.create(book: b, genre: g)
  end
  b.image.attach(io:       File.open(Rails.root.join("app/assets/images/#{book['Image']}")),
                 filename: book["Image"])
end

# if Rails.env.development?
#   AdminUser.create!(email: "admin@example.com", password: "password",
#                     password_confirmation: "password")
# end

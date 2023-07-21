# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Identity.transaction do
  1..9.each do |i|
    SignupService.new(
      {
        email: "email#{i}@email.com",
        cid: "00000#{i}",
        password: "!@#123QWEqwe#{i}"
      }
    ).call
  end
end

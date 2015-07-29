afya = {
  name: "Afya"
}

School.create(afya)

six_zero_one = {
  teacher_id: 1,
  klass_number: 601,
  school_year: 2015,
  grade: 6
}

Klass.create(six_zero_one)

april = {
  first_name: "april",
  last_name: "dixon",
  password: "password",
  handle: "@adixon",
  klass_number: 601,
  lexile_level: 900,
  klass_id: 1
}

Student.create(april)

asha = {
  first_name: "asha",
  last_name: "hines",
  password: "password",
  handle: "@ahines",
  klass_number: 601,
  lexile_level: 800,
  klass_id: 1
}

Student.create(asha)


text_one = {
  isbn: 12323513,
  title: "First Best Book",
  lexile_level: 700,
  pages: 500,
  author: "McJohn",
  genre: "Mystery"
}

text_two = {
  isbn: 12424423,
  title: "Second Best Book",
  lexile_level: 670,
  pages: 550,
  author: "Lenny",
  genre: "Science Fiction"
}

Text.create(text_one)
Text.create(text_two)


molly = {
  prefix: "Ms.",
  first_name: "Molly",
  last_name: "Grant",
  email: "mg@gmail.com",
  password: "password",
  admin: true,
}

teacher = Teacher.new(prefix: molly[:prefix], email: molly[:email], first_name: molly[:first_name], last_name: molly[:last_name], admin: molly[:admin])
teacher.password =  molly[:password]
school = School.find_by(name:  "Afya")
teacher.school_id = school.id
teacher.save!


author_one = {
  first_name: "F. Scott",
  last_name: "Fitzgerald"
}

author_two = {
  first_name: "Albert",
  last_name: "Morris"
}

Author.create(author_one)
Author.create(author_two)

genre_one = {
  category: "Mystery"
}

genre_two = {
  category: "Science Fiction"
}

genre_three = {
  category: "Fantasy"
}

genre_four = {
  category: "Historical Fiction"
}

genre_five = {
  category: "Biographies"
}

genre_six = {
  category: "Informational"
}

Genre.create(genre_one)
Genre.create(genre_two)
Genre.create(genre_three)
Genre.create(genre_four)
Genre.create(genre_five)
Genre.create(genre_six)




quotes_file = File.open('db/literary_quotes.txt')

contents = []
sources = []

quotes_file.each_with_index do |file_line, index|
  if index%2 == 0
    contents << file_line
  else
    sources << file_line
  end
end

40.times do |index|
  Quote.create(content: contents[index], source: sources[index])
end


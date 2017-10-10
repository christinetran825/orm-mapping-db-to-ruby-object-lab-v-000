class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = <<-SQL
      SELECT *
      FROM students
    SQL
  end

  # describe '.all' do
  #   it 'returns all student instances from the db' do
  #     pat.name = "Pat"
  #     pat.grade = 12
  #     pat.save
  #     sam.name = "Sam"
  #     sam.grade = 10
  #     sam.save
  #
  #     all_from_db = Student.all
  #     expect(all_from_db.size).to eq(2)
  #     expect(all_from_db.last).to be_an_instance_of(Student)
  #     expect(all_from_db.any? {|student| student.name == "Sam"}).to eq(true)
  #   end
  # end


  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class

  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end

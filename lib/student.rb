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
    DB[:conn].execute(sql)
  end


  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name = ?
      LIMIT 1
    SQL
    
    DB[:conn].execute(sql)
  end

  # describe 'retrieving data from the db' do
  #   describe '.find_by_name' do
  #
  #     it 'returns an instance of student that matches the name from the DB' do
  #       pat.name = "Pat"
  #       pat.grade = 12
  #       pat.save
  #
  #       pat_from_db = Student.find_by_name("Pat")
  #       expect(pat_from_db.name).to eq("Pat")
  #       expect(pat_from_db).to be_an_instance_of(Student)
  #     end
  #   end



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

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
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
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

    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.count_all_students_in_grade_9
    sql = <<-SQL
      SELECT COUNT(*)
      FROM students
      WHERE grade = ?
    SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.students_below_12th_grade
    sql = <<-SQL
      SELECT COUNT(*)
      FROM students
      WHERE grade < ?
    SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.first_X_students_in_grade_10
    sql = <<-SQL
      SELECT COUNT(*)
      FROM students
      WHERE grade < ?
    SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end.first
  end
  #
  # describe '.first_X_students_in_grade_10' do
  #   it 'returns an array of the first X students in grade 10' do
  #
  #     pat.name = "Pat"
  #     pat.grade = 10
  #     pat.save
  #     sam.name = "Sam"
  #     sam.grade = 10
  #     sam.save
  #     jess.name = "Jess"
  #     jess.grade = 10
  #     jess.save
  #
  #     first_X_students = Student.first_X_students_in_grade_10(2)
  #     expect(first_X_students.size).to eq(2)
  #   end
  # end

  def self.first_student_in_grade_10
    # sql = <<-SQL
    #   SELECT COUNT(*)
    #   FROM students
    #   WHERE grade = ?
    # SQL
    #
    # DB[:conn].execute(sql).map do |row|
    #   self.new_from_db(row)
    # end.first
  end

  # describe '.first_student_in_grade_10' do
  #   it 'returns the first student in grade 10' do
  #     pat.name = "Pat"
  #     pat.grade = 12
  #     pat.id = 1
  #     pat.save
  #
  #     sam.name = "Sam"
  #     sam.grade = 10
  #     sam.id = 2
  #     sam.save
  #
  #     jess.name = "Jess"
  #     jess.grade = 10
  #     jess.id = 3
  #     jess.save
  #
  #     first_student = Student.first_student_in_grade_10
  #     expect(first_student.id).to eq(2)
  #     expect(first_student.name).to eq("Sam")

  def self.all_students_in_grade_X

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

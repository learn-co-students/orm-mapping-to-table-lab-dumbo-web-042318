class Student
  attr_accessor :name, :grade
  attr_reader :id


  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

#Create Table class method
  def self.create_table
    sql = <<TEXT
    CREATE TABLE students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    );
TEXT

  DB[:conn].execute(sql)
  end

#Drop Table Class Method
  def self.drop_table
    sql = <<TEXT
    DROP TABLE students;
TEXT
  DB[:conn].execute(sql)
  end

#Save instance Method
#   def save
#     sql = <<TEXT
#       INSERT INTO students(name, grade)
#       VALUES (?, ?)
# TEXT
#
#   DB[:conn].execute(sql, self.name, self.grade)
#   end

def save
  sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL

  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
end

  def self.create(hash)
    student = Student.new(hash[:name], hash[:grade])
    student.save
    student
  end

end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

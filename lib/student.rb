class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  @@id_count=1
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.id_count
    @@id_count
  end

  def self.table_name
    self.name.downcase + 's'
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS #{table_name} (id INTEGER, name TEXT, grade TEXT)"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS #{table_name}"
    DB[:conn].execute(sql)
  end

  def save

    sql = <<-SQL
      INSERT INTO students (id, name, grade)
      VALUES (?,?, ?)
    SQL

    last_id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")
# [[]]

    if last_id == []
      @id=1
    else
      @id = last_id[0][0]+ 1
    end

    # @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0][0] + 1
    DB[:conn].execute(sql, @id, self.name, self.grade)
    # @@id_count +=1
    end

  def self.create(name:, grade:)
      student = Student.new(name, grade)
      student.save
      student
  end

end

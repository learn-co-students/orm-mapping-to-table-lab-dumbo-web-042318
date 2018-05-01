class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  @@table_name = self.name.downcase + 's'

  def initialize(id=nil,name, grade)
    @id = id 
    @name = name
    @grade = grade 
  end 

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS #{@@table_name} (
        id INTEGER PRIMARY KEY, 
        name TEXT,
        grade TEXT);
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS #{@@table_name}
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO #{@@table_name} (name, grade) 
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.grade)
 
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{@@table_name}")[0][0]

  end

  def self.create(student_hash) # these require hash to have these keys 
    student = self.new(student_hash[:name], student_hash[:grade])
    student.save
    return student
  end



end

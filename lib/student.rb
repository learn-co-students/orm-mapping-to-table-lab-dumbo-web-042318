class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.table_name
    "#{self.name.downcase}s"
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE #{table_name} (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE #{table_name};"

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO #{self.class.table_name} (name, grade)
      VALUES (?, ?);
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{self.class.table_name}")[0][0]
  end

  def self.create(attributes)
    student = self.new(attributes[:name], attributes[:grade])
    student.save
    student
  end

end

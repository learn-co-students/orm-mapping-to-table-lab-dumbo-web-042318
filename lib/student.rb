require 'pry'

class Student
  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id 
  end
  
  def self.create_table 
    sql = <<-SQL
      CREATE TABLE students (
        name TEXT,
        grade INTEGER,
        id INTEGER PRIMARY KEY
      );
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
  end
  
  
end

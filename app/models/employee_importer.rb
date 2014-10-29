module EmployeeImporter
  class << self
    def import_file(file)
      @roles  = Role.all.index_by(&:name)
      @grades = Grade.all.index_by(&:name)

      CSV.foreach(file.tempfile) do |row|
        import_row row
      end
    end

    def import_row(row)
      role  = @roles[row[3]]  || Role.create(name: row[3])
      grade = @grades[row[4]] || Grade.create(name: row[4])

      employee = Employee.find_by(employee_id: row[0]) || Employee.new(employee_id: row[0])
      employee.name = row[1]
      employee.grade = grade
      employee.role = role
      employee.save
    end
  end
end

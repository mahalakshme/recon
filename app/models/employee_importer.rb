module EmployeeImporter
  class << self
    def import_file(file)
      @roles  = Role.all.index_by(&:name)
      @grades = Grade.all.index_by(&:name)

      CSV.foreach(file.tempfile, headers: true, return_headers: false) do |row|
        import_row row
      end
    end

    def import_row(row)
      role = @roles[row['Role']] || Role.create(name: row['Role'])
      grade = @grades[row['Grade']] || Grade.create(name: row['Grade'])

      employee = Employee.find_by(employee_id: row['Employee ID']) || Employee.new(employee_id: row['Employee ID'])
      employee.name = row['Name']
      employee.grade = grade
      employee.role = role
      employee.save!
    end
  end
end

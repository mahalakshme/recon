module EmployeeImporter
  class << self
    def import_file(file)
      @roles  = Role.all.index_by { |r| r.name.downcase.strip }
      @grades = Grade.all.index_by { |g| g.name.downcase.strip }

      CSV.foreach(file.tempfile, headers: true, return_headers: false) do |row|
        import_row row
      end
    end

    def fetch_role(row)
      role = @roles[row['Role'].downcase.strip]
      if !role
        role = Role.create!(name: row['Role'])
        @roles = Role.all.index_by { |r| r.name.downcase.strip }
      end
      role
    end

    def fetch_grade(row)
      grade = @grades[row['Grade'].downcase.strip]
      if !grade
        grade = Grade.create!(name: row['Grade'])
        @grades = Grade.all.index_by { |g| g.name.downcase.strip }
      end
      grade
    end

    def import_row(row)
      role  = fetch_role row
      grade = fetch_grade row

      employee = Employee.find_by(employee_id: row['Employee ID']) || Employee.new(employee_id: row['Employee ID'])
      employee.name = row['Name']
      employee.grade = grade
      employee.role = role
      employee.inactive = grade.inactive || role.inactive
      employee.save!
    end
  end
end

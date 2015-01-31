class ContributionReport

  def self.generate(employees, start_date, end_date)
    stages = Stage.order(:position).to_a
    header = [ "ID", "Name", "Role", "Grade", "Total" ] + stages.collect(&:name)

    CSV.generate do |csv|
      csv << header
      employees.each do |e|
        interviews = e.interviews.where('interview_date >= ? and interview_date <= ?', start_date, end_date).to_a
        row = [ e.employee_ref, e.name, e.role.name, e.grade.name, interviews.size ]
        stages.each do |stage|
          row << interviews.reduce(0) { |sum, i| sum + (i.stage_id == stage.id ? 1 : 0) }
        end
        csv << row
      end
    end
  end

end

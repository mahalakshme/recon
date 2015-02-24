ActiveAdmin.register Interview do
  filter :candidate
  filter :stage
  filter :interview_date
  filter :status, as: :select, multiple: true, input_html: { class: 'selectize' }, label: 'Status', collection: proc { Interview.statuses }

  index do
    column 'Name' do |interview|
      interview.candidate.name
    end
    column 'Experience' do |interview|
      "#{interview.candidate.experience_years},#{interview.candidate.experience_months}"
    end
    column 'Source' do |interview|
      interview.candidate.source.name
    end
    column 'Role' do |interview|
      interview.candidate.role.name
    end
    column 'Stage' do |interview|
      interview.stage.name
    end
    column 'Date' do |interview|
      interview.interview_date.strftime '%a %b %-d, %I:%M %p'
    end
    column 'Panel' do |interview|
      interview.employees.collect(&:name).join(",")
    end
    column 'Status' do |interview|
      interview.status
    end
  end
end

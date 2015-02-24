ActiveAdmin.register Interview do
  filter :candidate, as: :select, input_html: { class: 'selectize' }, collection: proc { Candidate.all }
  filter :stage
  filter :role, as: :select, multiple: true, input_html: { class: 'selectize' }, collection: proc { Role.all }
  filter :interview_date
  filter :status, as: :select, multiple: true, input_html: { class: 'selectize' }, label: 'Status', collection: proc { Interview.statuses }

  controller do
    def scoped_collection
      super.includes :candidate
    end
  end

  index do
    column :name, sortable: :name do |interview|
      interview.candidate.name
    end
    column :experience, sortable: :experience do |interview|
      "#{interview.candidate.experience_years},#{interview.candidate.experience_months}"
    end
    column :source, sortable: :source do |interview|
      interview.candidate.source.name
    end
    column :role, sortable: :role do |interview|
      interview.candidate.role.name
    end
    column :stage, sortable: :stage do |interview|
      interview.stage.name
    end
    column :date, sortable: :date do |interview|
      interview.interview_date.strftime '%a %b %-d, %I:%M %p'
    end
    column :panel, sortable: :panel do |interview|
      interview.employees.collect(&:name).join(",")
    end
    column :status, sortable: :status do |interview|
      interview.status
    end
  end
end

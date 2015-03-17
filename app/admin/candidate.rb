ActiveAdmin.register Candidate do

  permit_params :id, :name, :skill, :gender, :experience_years, :experience_months, :source_id, :role_id, :notes,
    interviews_attributes: [ :id, :stage_id, :interview_date, :candidate_id, :status, :notes, :_destroy, employee_ids: [] ]

  filter :name
  filter :experience
  filter :gender, as: :select, multiple: true, input_html: { class: 'selectize' }, collection: proc { Candidate.genders }
  filter :role, as: :select, multiple: true, input_html: { class: 'selectize' }, collection: proc { Role.all }

  filter :interviews_stage_id, as: :select, multiple: true, input_html: { class: 'selectize' }, label: 'Any Interview Stage', collection: proc { Stage.all }
  filter :interviews_status, as: :select, multiple: true, input_html: { class: 'selectize' }, label: 'Any Interview Status', collection: proc { Interview.statuses }
  filter :interviews_interview_date, as: :date_range, label: 'Any Interview Date'

  filter :last_stage, as: :select, multiple: true, input_html: { class: 'selectize' }, collection: proc { Stage.all }, label: 'Latest Interview Stage'
  filter :last_status, as: :select, multiple: true, input_html: { class: 'selectize' }, collection: proc { Candidate.last_statuses }, label: 'Latest Interview Status'
  filter :last_interview_date, as: :date_range, label: 'Latest Interview Date'

  config.sort_order = "last_interview_date_desc"

  controller do
    def scoped_collection
      Candidate.includes_meta.includes_interviews.group('candidates.id')
    end
  end

  index do
    column :name
    column :experience, :experience do |c|
      "#{c.experience_years},#{c.experience_months}"
    end
    column :last_status
    column :last_stage
    column :last_interview_date do |c|
      c.last_interview_date.strftime '%a %b %-d, %I:%M %p'
    end
    column :role
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Candidate Details" do
      f.input :name
      f.input :experience_years
      f.input :experience_months
      f.input :skill
      f.input :gender, as: :select, collection: Candidate.genders.keys
      f.input :source_id, as: :select, collection: option_groups_from_collection_for_select(
        SourceGroup.all, :sources, :name, :id, :name, f.object.source_id
      )
      f.input :role
      f.input :notes, input_html: { rows: 2 }
    end

    f.has_many :interviews, heading: 'Interview Stages', allow_destroy: true do |fi|
      fi.input :interview_date, as: :jquery_datetime_picker
      fi.input :stage, as: :select, collection: Stage.all
      fi.input :status, as: :select, collection: Interview.statuses.keys
      fi.input :employees, as: :selectize_autocomplete, selectize: { url: autocomplete_admin_employees_path }, multiple: true
      fi.input :notes, input_html: { rows: 2 }
    end

    f.actions
  end

  show do |c|
    attributes_table do
      row :name
      row :experience do
        "#{c.experience_years} years #{c.experience_months} months"
      end
      row :role
      row :skill
      row :gender
      row :source
      row :last_interview_date
      row :last_status
      row :notes
      row :created_at
      row :updated_at
    end

    panel "Stages" do
      table_for c.interviews.order(:interview_date) do
        column :interview_date
        column :stage
        column :status
        column :notes
        column :employees do |i|
          i.employees.map do |e|
            link_to e.name, [:admin, e]
          end.join(', ').html_safe
        end
      end
    end
  end

end

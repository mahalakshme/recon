ActiveAdmin.register Candidate do

  permit_params :id, :name, :skill, :gender, :experience_years, :experience_months, :source_id, :role_id,
    interviews_attributes: [ :id, :stage_id, :interview_date, :candidate_id, :employee_1_id, :employee_2_id, :employee_3_id, :status, :_destroy ]

  filter :name
  filter :skill
  filter :experience
  filter :gender, as: :select, collection: Candidate.genders, multiple: true, input_html: { class: 'selectize' }
  filter :source, as: :select, collection: proc {
    option_groups_from_collection_for_select(
      SourceGroup.all, :sources, :name, :id, :name
    )
  }, multiple: true, input_html: { class: 'selectize' }
  filter :role, as: :select, multiple: true, input_html: { class: 'selectize' }
  filter :last_status, as: :select, collection: Candidate.last_statuses, multiple: true, input_html: { class: 'selectize' }
  filter :last_stage, as: :select, collection: Stage.all, multiple: true, input_html: { class: 'selectize' }
  filter :last_interview_date

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
    column :skill
    column :source
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
      fi.input :employee_1, as: :selectize_autocomplete, selectize: { url: autocomplete_employees_path }
      fi.input :employee_2, as: :selectize_autocomplete, selectize: { url: autocomplete_employees_path }
      fi.input :employee_3, as: :selectize_autocomplete, selectize: { url: autocomplete_employees_path }
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
        column :employee_1
        column :employee_2
        column :employee_3
      end
    end
  end

end

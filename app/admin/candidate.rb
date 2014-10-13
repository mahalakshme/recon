ActiveAdmin.register Candidate do

  enumize = proc { |k,v| [k.to_s.titleize, k] }

  permit_params :id, :name, :skill, :gender, :experience, :source_id, :role_id, :last_interview_date,
    interviews_attributes: [ :id, :stage, :interview_date, :candidate_id, :employee_1_id, :employee_2_id, :employee_3_id, :status, :_destroy ]

  filter :name
  filter :skill
  filter :experience
  filter :gender, as: :select, collection: Candidate.genders.map(&enumize)
  filter :source, as: :select, collection: proc {
    option_groups_from_collection_for_select(
      SourceGroup.all, :sources, :name, :id, :name
    )
  }
  filter :role
  filter :last_interview_date

  index do
    column :last_interview_date
    column :name
    column :experience
    column :skill
    column :source
    column :role
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Candidate Details" do
      f.input :name
      f.input :experience
      f.input :skill
      f.input :gender, as: :select, collection: Candidate.genders.map(&enumize)
      f.input :source_id, as: :select, collection: option_groups_from_collection_for_select(
        SourceGroup.all, :sources, :name, :id, :name, f.object.source_id
      )
      f.input :role
    end

    f.has_many :interviews, heading: 'Interview Stages', allow_destroy: true do |fi|
      fi.input :interview_date, as: :datepicker
      fi.input :stage, as: :select, collection: Interview.stages.map(&enumize)
      fi.input :status, as: :select, collection: Interview.statuses.map(&enumize)
      fi.input :employee_1
      fi.input :employee_2
      fi.input :employee_3
    end

    f.actions
  end

  show do |c|
    attributes_table do
      row :name
      row :experience
      row :role
      row :skill
      row :gender do c.gender.to_s.titleize end
      row :source
      row :last_interview_date
      row :created_at
      row :updated_at
    end

    panel "Stages" do
      table_for c.interviews.order(:interview_date) do
        column :interview_date
        column :stage do |i| i.stage.to_s.titleize end
        column :status do |i| i.status.to_s.titleize end
        column :employee_1
        column :employee_2
        column :employee_3
      end
    end
  end

end

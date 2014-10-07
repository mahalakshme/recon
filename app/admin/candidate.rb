ActiveAdmin.register Candidate do

  enumize = proc { |k,v| [k.to_s.titleize, k] }

  permit_params :id, :name, :skill, :gender, :sub_source_id, :last_interview_date,
    interviews_attributes: [ :id, :stage, :interview_date, :candidate_id, :employee_id, :status, :_destroy ]

  filter :name
  filter :skill
  filter :gender, as: :select, collection: Candidate.genders.map(&enumize)
  filter :sub_source, as: :select, collection: proc {
    option_groups_from_collection_for_select(
      Source.all, :sub_sources, :name, :id, :name
    )
  }
  filter :last_interview_date

  index do
    column :last_interview_date
    column :name
    column :gender do |i| i.gender.to_s.titleize end
    column :skill
    column :sub_source
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Candidate Details" do
      f.input :name
      f.input :skill
      f.input :gender, as: :select, collection: Candidate.genders.map(&enumize)
      f.input :sub_source_id, label: 'Source', as: :select, collection: option_groups_from_collection_for_select(
        Source.all, :sub_sources, :name, :id, :name, f.object.sub_source_id
      )
    end

    f.has_many :interviews, heading: 'Interview Stages', allow_destroy: true do |fi|
      fi.input :interview_date, as: :datepicker
      fi.input :stage, as: :select, collection: Interview.stages.map(&enumize)
      fi.input :status, as: :select, collection: Interview.statuses.map(&enumize)
      fi.input :employee
    end

    f.actions
  end

  show do |c|
    attributes_table do
      row :name
      row :skill
      row :gender do c.gender.to_s.titleize end
      row :sub_source_id
      row :last_interview_date
      row :created_at
      row :updated_at
    end

    panel "Stages" do
      table_for c.interviews.order(:interview_date) do
        column :interview_date
        column :stage do |i| i.stage.to_s.titleize end
        column :employee
        column :status do |i| i.status.to_s.titleize end
      end
    end
  end

end

ActiveAdmin.register_page 'Pipeline' do

  menu priority: 2

  content title: 'Pipeline' do

    candidates = Candidate.
      order(:last_interview_date).
      where('last_interview_date >= ?', Date.today).
      where('last_interview_date <= ?', 7.days.from_now)

    stages = Stage.all

    columns style: "width: #{stages.length*20}rem" do
      stages.each do |stage|
        column do
          panel stage.name do
            candidates.where(last_stage: stage).each do |candidate|
              div class: 'candidate' do
                h3 candidate.name, class: 'name'
                div candidate.last_status, class: 'status'
                div candidate.last_interview_date.strftime('%a %b %-d, %I:%M %p'), class: 'date'
              end
            end
          end
        end
      end
    end
  end

end

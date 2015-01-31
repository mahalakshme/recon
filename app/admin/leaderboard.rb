ActiveAdmin.register Employee, as: 'Leaderboard', namespace: :guest do

  menu priority: 1
  actions :index

  filter :role
  filter :grade
  filter :interviews_interview_date, as: :date_range, label: 'Interview Date'

  config.sort_order = "points_desc"

  controller do
    before_action do
      params[:q] ||= {}
      params[:q][:interviews_interview_date_gteq] = leaderboard_start_date
      params[:q][:interviews_interview_date_lteq] = leaderboard_end_date
    end

    def scoped_collection
      Employee.includes_meta.joins(interviews: :stage).select('employees.*', 'coalesce(sum(stages.points), 0) points').group('employees.id')
    end

    def leaderboard_start_date
      @start_date ||= Time.zone.parse(params[:q][:interviews_interview_date_gteq]) rescue Time.zone.now.at_beginning_of_month
    end

    def leaderboard_end_date
      @end_date ||= Time.zone.parse(params[:q][:interviews_interview_date_lteq] + ' 23:59:59') rescue Time.zone.now.at_end_of_month
    end

    def leaderboard_title
      'Leaderboard for %s - %s' % [leaderboard_start_date.strftime('%b %d'), leaderboard_end_date.strftime('%b %d')]
    end
  end

  index download_links: false, title: Proc.new{ leaderboard_title } do
    column :employee_ref
    column :name do |e|
      link_to e.name, [:admin, e]
    end
    column :role
    column :grade
    column :points, sortable: :points
  end

  action_item do
    link_to "Contribution Report", params.merge(action: :contribution_report) if current_admin_user.present?
  end

  collection_action :contribution_report, method: :get do
    csv = ContributionReport.generate Employee.includes_meta, leaderboard_start_date, leaderboard_end_date
    filename = "contribution_report.csv"
    send_data csv, filename: filename, type: 'text/csv'
  end

end

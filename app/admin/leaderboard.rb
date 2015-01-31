ActiveAdmin.register Employee, as: 'Leaderboard', namespace: :guest do

  JOIN_SQL = <<-QUERY
    INNER JOIN (
      SELECT e.id AS id,
      COALESCE(SUM(s.points), 0) AS points
      FROM employees e
      LEFT OUTER JOIN employee_interviews ei ON ei.employee_id = e.id
      LEFT OUTER JOIN interviews i ON (
        i.id = ei.interview_id AND
        i.interview_date >= '%{start_date}' AND
        i.interview_date <= '%{end_date}'
      )
      LEFT OUTER JOIN stages s ON s.id = i.stage_id
      GROUP BY e.id
    ) points ON points.id = employees.id
  QUERY

  menu priority: 1
  actions :index

  filter :role
  filter :grade

  config.sort_order = "points_desc"

  controller do
    def scoped_collection
      Employee.includes_meta.joins(
        JOIN_SQL % { start_date: leaderboard_date.at_beginning_of_month.iso8601, end_date: leaderboard_date.at_end_of_month.iso8601 }
      ).select(
        "employees.id, employees.employee_ref, employees.name, employees.role_id, employees.grade_id, points.points"
      )
    end

    def leaderboard_date
      @leaderboard_date ||= (Time.zone.parse(params[:date]) rescue Time.zone.now)
    end
  end

  index title: Proc.new{ "Leaderboard for #{leaderboard_date.strftime('%b %Y')}" }, download_links: false do
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
    csv = ContributionReport.generate(Employee.includes_meta, leaderboard_date.at_beginning_of_month, leaderboard_date.at_end_of_month)
    filename = "contribution_report_#{leaderboard_date.strftime('%b_%Y')}.csv"
    send_data csv, filename: filename, type: 'text/csv'
  end

end

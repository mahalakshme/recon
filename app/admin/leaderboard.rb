ActiveAdmin.register Employee, namespace: 'leaderboard' do

  JOIN_SQL = <<-QUERY
    INNER JOIN (
      SELECT e.id AS id,
      COALESCE(SUM(s.points), 0) AS points
      FROM employees e
      LEFT OUTER JOIN interviews i ON (
        i.interview_date >= '%{start_date}' AND i.interview_date <= '%{end_date}' AND
        e.id = i.employee_1_id OR e.id = i.employee_2_id OR e.id = i.employee_3_id
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
    skip_before_filter :authenticate_active_admin_user

    def scoped_collection
      Employee.joins(
        JOIN_SQL % { start_date: leaderboard_date.at_beginning_of_month.iso8601, end_date: leaderboard_date.at_end_of_month.iso8601 }
      ).select(
        "employees.id, employees.employee_ref, employees.name, employees.role_id, employees.grade_id, points.points"
      )
    end

    def leaderboard_date
      Time.zone.parse(params[:date]) rescue Time.zone.now
    end
  end

  index title: Proc.new{ "Leaderboard for #{leaderboard_date.strftime('%b %Y')}" } do
    column :employee_ref
    column :name do |e|
      link_to e.name, employee_path(e)
    end
    column :role
    column :grade
    column :points, sortable: :points
  end

end

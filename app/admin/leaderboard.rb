ActiveAdmin.register_page "Leaderboard" do

  controller do
    skip_before_filter :authenticate_active_admin_user
  end

  menu priority: 1

  content title: "Leaderboard" do

    num_days  = params[:days].present?  ? params[:days].to_i  : 90
    num_limit = params[:limit].present? ? params[:limit].to_i : 10
    cache_key = Interview.order(:updated_at).last.try(:updated_at).try(:to_i)

    sql = <<-QUERY
      SELECT
        e.id AS employee_id,
        e.name AS employee_name,
        COALESCE(SUM(s.points), 0) AS points

      FROM employees e
      LEFT OUTER JOIN interviews i ON (
        i.interview_date >= '%{date}' AND
        (e.id = i.employee_1_id OR e.id = i.employee_2_id OR e.id = i.employee_3_id)
      )
      LEFT OUTER JOIN stages s ON s.id = i.stage_id

      WHERE e.inactive = 'f'
      AND e.role_id = %{role_id}

      GROUP BY e.id
      ORDER BY points %{sort}
      LIMIT %{limit}
    QUERY

    columns do
      column do
        h3 "Most Interviewers by Role (#{num_days} days)"

        Role.active.each do |role|
          panel role.name do
            records = Rails.cache.fetch("leaderboard/#{cache_key}/most/#{role.id}", expires_in: 1.hour) do
              query = sql % { date: num_days.days.ago.rfc2822, role_id: role.id, sort: 'DESC', limit: num_limit }
              ActiveRecord::Base.connection.execute(query).to_a
            end

            table_for records do
              column 'Employee' do |r| link_to r['employee_name'], employee_path(r['employee_id']) end
              column 'Points' do |r| r['points'] end
            end if records.length > 0
          end
        end
      end

      column do
        h3 "Least Interviewers by Role (#{num_days} days)"

        Role.active.each do |role|
          panel role.name do
            records = Rails.cache.fetch("leaderboard/#{cache_key}/least/#{role.id}", expires_in: 1.hour) do
              query = sql % { date: num_days.days.ago.rfc2822, role_id: role.id, sort: 'ASC', limit: num_limit }
              ActiveRecord::Base.connection.execute(query).to_a
            end

            table_for records do
              column 'Employee' do |r| link_to r['employee_name'], employee_path(r['employee_id']) end
              column 'Points' do |r| r['points'] end
            end if records.length > 0
          end
        end
      end
    end

  end
end

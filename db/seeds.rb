# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Grade.create! name: 'Grad'
Grade.create! name: 'Consultant'
Grade.create! name: 'Senior Consultant'
Grade.create! name: 'Lead Consultant'
Grade.create! name: 'Principal Consultant'

Role.create! name: 'Dev'
Role.create! name: 'PM'
Role.create! name: 'BA'
Role.create! name: 'QA'
Role.create! name: 'UI'
Role.create! name: 'UX'

Source.create! name: 'Employee Referral' do |s|
  SubSource.create! name: 'Employee Referral', source: s
end

Source.create! name: 'Mindshare' do |s|
  SubSource.create! name: 'Mindshare', source: s
end

Source.create! name: 'Agency' do |s|
  SubSource.create! name: 'EPP', source: s
  SubSource.create! name: 'HNB', source: s
  SubSource.create! name: 'Other', source: s
end

Source.create! name: 'Naukri' do |s|
  SubSource.create! name: 'Naukri', source: s
end

Source.create! name: 'Monster' do |s|
  SubSource.create! name: 'Monster', source: s
end

Source.create! name: 'LinkedIn' do |s|
  SubSource.create! name: 'In Mail', source: s
  SubSource.create! name: 'Job Posting', source: s
  SubSource.create! name: 'Recruiter Network', source: s
  SubSource.create! name: 'Other', source: s
end

Source.create! name: 'Marketing Campaign' do |s|
  SubSource.create! name: 'Hacker Earth', source: s
  SubSource.create! name: 'Other', source: s
end

Source.create! name: 'Events' do |s|
  SubSource.create! name: 'Rails Girls', source: s
  SubSource.create! name: 'Geek Night', source: s
  SubSource.create! name: 'VodQA', source: s
end

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

SourceGroup.create! name: 'Employee Referral' do |s|
  Source.create! name: 'Employee Referral', source_group: s
end

SourceGroup.create! name: 'Mindshare' do |s|
  Source.create! name: 'Mindshare', source_group: s
end

SourceGroup.create! name: 'Agency' do |s|
  Source.create! name: 'EPP', source_group: s
  Source.create! name: 'HNB', source_group: s
  Source.create! name: 'Other', source_group: s
end

SourceGroup.create! name: 'Naukri' do |s|
  Source.create! name: 'Naukri', source_group: s
end

SourceGroup.create! name: 'Monster' do |s|
  Source.create! name: 'Monster', source_group: s
end

SourceGroup.create! name: 'LinkedIn' do |s|
  Source.create! name: 'In Mail', source_group: s
  Source.create! name: 'Job Posting', source_group: s
  Source.create! name: 'Recruiter Network', source_group: s
  Source.create! name: 'Other', source_group: s
end

SourceGroup.create! name: 'Marketing Campaign' do |s|
  Source.create! name: 'Hacker Earth', source_group: s
  Source.create! name: 'Other', source_group: s
end

SourceGroup.create! name: 'Events' do |s|
  Source.create! name: 'Rails Girls', source_group: s
  Source.create! name: 'Geek Night', source_group: s
  Source.create! name: 'VodQA', source_group: s
end

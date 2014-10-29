# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if AdminUser.count == 0
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

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
end

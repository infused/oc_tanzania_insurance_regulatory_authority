# -*- coding: utf-8 -*-

require 'json'
require 'mechanize'
require 'turbotlib'

url = 'http://www.tira.go.tz/?q=insurancecompanies'

agent = Mechanize.new
page = agent.get(url)
page.search('.view-companies .views-row').each do |co|
  data = {
    company_name: co.search('.views-field-title a').text,
    address: co.search('.views-field-field-address .field-content').text.split("\r\n").map {|x| x.strip}.join(', '),
    fax: co.search('.views-field-field-fax .field-content').text,
    telephone: co.search('.views-field-field-telephone .field-content').text,
    mobile: co.search('.views-field-field-mobile .field-content').text,
    email: co.search('.views-field-field-email .field-content').text,
    url: co.search('.views-field-field-website .field-content').text,
    principle_officer: co.search('.views-field-field-principle_officer').text,
    category: 'Insurance Company',
    source_url: url,
    sample_date: Time.now
  }

  puts JSON.dump(data)
end

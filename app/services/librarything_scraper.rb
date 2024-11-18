require 'httparty'
require 'nokogiri'

class LibrarythingScraper
  BASE_URL = 'https://www.librarything.com/mds/'.freeze


  (0..1_000).each do |i|
    
  end

  def convert_to_int_string(num)
    "#{num.to_s.rjust(3, '0')}."
  end

  def add_decimal_place(num_string)
    "#{num_string}0"
  end

  def add_one_to_decimal_place(num_string)
    num_string[-1] == '9' ? nil : num_string[0...-1] + (num_string[-1].to_i + 1).to_s
  end





  def self.get_text(ddc)
    url = "#{BASE_URL}#{ddc}"
    sleep(2)
    Rails.logger.info("ddc: #{ddc}")
    response = HTTParty.get(url)

    if response.code == 200
      Rails.logger.info('success!')
      parse_data(response.body)
    else
      Rails.logger.error "Failed to fetch data for ISBN #{isbn}. HTTP Status: #{response.code}. "
      nil
    end
  end

  def self.parse_data(html)
    doc = Nokogiri::HTML(html)
    Rails.logger.info("parse_data: #{doc}")
    # Example: Extracting book Dewey Decimal Code
    ddc = doc.search('td[fieldname="modernschedule"] div div a')&.text&.strip
    Rails.logger.info "Found #{ddc}"
    ddc if ddc.present?
  end
end
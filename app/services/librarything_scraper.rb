require 'httparty'
require 'nokogiri'

class LibrarythingScraper
  BASE_URL = 'https://www.librarything.com/mds/'.freeze
  class << self

    def get_sub_divisions
      subdivisions = []
      (0..1_000).each do |i|
        ddc_int_string = convert_to_int_string(i)
        recursive_lookup(add_decimal_place(ddc_int_string), subdivisions)
      end
    end

    def get_text(ddc)
      url = "#{BASE_URL}#{ddc}"
      sleep(2)
      Rails.logger.info("ddc: #{ddc}")
      response = HTTParty.get(url)

      if response.code == 200
        Rails.logger.info('success!')
        parse_data(response.body, ddc)
      else
        Rails.logger.error "Failed to fetch data for ISBN #{isbn}. HTTP Status: #{response.code}. "
        nil
      end
    end

    private

    def recursive_lookup(ddc_string, collection_array)
      ;
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

    def parse_data(html, ddc)
      doc = Nokogiri::HTML(html)
      ddc = doc.search("a[href='/mds/#{ddc}']")&.text&.strip&.slice(0...-1)
      Rails.logger.info "Found #{ddc}"
      ddc if ddc.present?
    end
  end
end

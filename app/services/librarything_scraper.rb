require 'httparty'
require 'nokogiri'

class LibrarythingScraper
  BASE_URL = 'https://www.librarything.com/isbn/'.freeze

  def self.scrape(isbn)
    url = "#{BASE_URL}#{isbn}"
    response = HTTParty.get(url, headers: { 'User-Agent' => 'Mozilla/5.0' })

    if response.code == 200
      parse_data(response.body)
    else
      Rails.logger.error "Failed to fetch data for ISBN #{isbn}. HTTP Status: #{response.code}. "
      nil
    end
  end

  def self.parse_data(html)
    doc = Nokogiri::HTML(html)

    # Example: Extracting book Dewey Decimal Code
    doc.search('//*[@class="fwikiItem divcanonicalddc"]/div/div/a')&.text&.strip
  end
end
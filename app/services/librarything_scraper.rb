require 'httparty'
require 'nokogiri'

class LibrarythingScraper
  BASE_URL = 'https://www.librarything.com/isbn/'.freeze

  def self.scrape(isbn)
    url = "#{BASE_URL}#{isbn}"
    Rails.logger.info("url: #{url}")
    response = HTTParty.get(url, headers: {
      'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
      'Accept-Encoding' => 'gzip, deflate, br',
      'Accept-Language' => 'en-US,en;q=0.9',
      'Connection' => 'keep-alive',
      'Upgrade-Insecure-Requests' => '1',
      'TE' => 'Trailers'
    })

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
    Rails.logger.info "Found #{doc}"
    # Example: Extracting book Dewey Decimal Code
    ddc = doc.search('//*[@class="fwikiItem divcanonicalddc"]/div/div/a')&.text&.strip
    Rails.logger.info "Found #{ddc}"
  end
end
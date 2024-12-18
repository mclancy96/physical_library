# frozen_string_literal: true
require 'httparty'
require 'nokogiri'
class GoodreadsScraper
  BASE_URL = 'https://www.goodreads.com/book/isbn/'

  class << self
    def scrape_goodreads(isbn)
      url = "#{BASE_URL}#{isbn}"
      response = HTTParty.get(url)
      if response.code == 200
        parse_data(response.body)
      else
        Rails.logger.error "Failed to fetch data for ISBN #{isbn}. HTTP Status: #{response.code}. "
        nil
      end
    end

    private

    def parse_data(html)
      doc = Nokogiri::HTML(html)
      rating = doc.xpath('//*[@class="RatingStatistics__rating"]')
      rating_count = doc.xpath('//*[@class="RatingStatistics__meta"]')
      [rating&.first&.text&.to_f, rating_count&.first&.text&.split(' ')&.first&.strip&.delete(',')&.to_i]
    end
  end
end
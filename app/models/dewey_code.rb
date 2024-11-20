# frozen_string_literal: true

class DeweyCode < ApplicationRecord
  belongs_to :parent, class_name: 'DeweyCode'
  has_many :children, class_name: 'DeweyCode'
  has_many :books
  def parent
    return nil if level <= 1

    parent_level = level - 1
    parent_code = code[-2] == '.' ? code[0...-2] : code[0...-1]
    DeweyCode.find_by(level: parent_level, code: parent_code)
  end

  def children
    DeweyCode.where('code LIKE ?', "#{code}%").and(DeweyCode.where('level = ? + 1', "#{level}%"))
  end
end

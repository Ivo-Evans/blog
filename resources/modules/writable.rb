# frozen_string_literal: true

require 'fileutils'

# receives arrays of strings and writes them to files
module Writable
  def self.write_to_main(new_file_name, new_text)
    FileUtils.cp('./resources/website-template.html', new_file_name)
    file = open('./' + new_file_name, 'r+:UTF-8')
    new_content = file.read.sub(/^\s*<!-- INSERT ARTICLES HERE -->/, new_text)
    file.truncate(0)
    file.rewind
    file.write(new_content)
    file.close
  end

  def self.write_articles(array_of_articles, to_file, namer, page_type)
    to_file = namer[page_type, to_file]
    new_text = array_of_articles.flatten.join("\n")
    write_to_main(to_file, new_text)
  end

  def self.write_pagination(pagination, this_page, namer, page_type)
    numbers = pagination.join("\n")
    page = open('./' + namer[page_type, this_page], 'r+:UTF-8')
    new_content = page.read.sub(/^\s*<!-- INSERT PAGINATION HERE -->/, numbers)
    page.truncate(0)
    page.rewind
    page.write(new_content)
    page.close
  end
end

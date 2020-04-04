# frozen_string_literal: true

require 'fileutils'

# receives arrays of strings and writes them to files
module Writable
  def self.write_to_main(new_file_name, new_text)
    FileUtils.cp('./resources/templates/website.html', new_file_name)
    file = open('./' + new_file_name, 'r+:UTF-8')
    new_content = file.read.sub(/^\s*<!-- INSERT ARTICLES HERE -->/, new_text)
    file.truncate(0)
    file.rewind
    file.write(new_content)
    file.close
  end

  def self.write_articles(array_of_articles, page_address)
    new_text = array_of_articles.flatten.join("\n")
    write_to_main(page_address, new_text)
  end

  def self.write_pagination(pagination, page_address)
    numbers = pagination.join("\n")
    page = open('./' + page_address, 'r+:UTF-8')
    new_content = page.read.sub(/^\s*<!-- INSERT PAGINATION HERE -->/, numbers)
    page.truncate(0)
    page.rewind
    page.write(new_content)
    page.close
  end

  def self.write_tag_sidebar(sidebar, page_address)
    sidebar = sidebar.join("\n")
    page = open('./' + page_address, 'r+:UTF-8')
    new_content = page.read.sub(/^\s*<!-- INSERT TAG-NAV HERE -->/, sidebar)
    page.truncate(0)
    page.rewind
    page.write(new_content)
    page.close
  end
end

# TODO: there should be a write_new_file method called from cm.rb but defined 
# here. Then write_articles should be removed - all it does could be done from 
# the wider scope, in Manageable. There should be a single method which takes
# a filename, a search term, and replacement content, which does all this opening,
# subbing and rewinding
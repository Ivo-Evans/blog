require 'fileutils'

module Writable
  def write_to_main(new_file_name, new_text)
    FileUtils.cp('./resources/website-template.html', new_file_name)    
    file = open("./" + new_file_name, 'r+:UTF-8')
    new_content = file.read.sub(/^\s*<!-- INSERT ARTICLES HERE -->/, new_text)
    file.truncate(0)
    file.rewind
    file.write(new_content)
    file.close
  end

  def write_articles(array_of_articles, to_file, namer)
    to_file = namer['index', to_file]
    new_text = array_of_articles.flatten.join("\n")
    write_to_main(to_file, new_text)
  end

  def write_pagination(pagination, this_page, namer)
    numbers = pagination.join("\n")
    page = open("./" + namer['index', this_page], 'r+:UTF-8')
    new_content = page.read.sub(/^\s*<!-- INSERT PAGINATION HERE -->/, numbers)
    page.truncate(0)
    page.rewind
    page.write(new_content)
    page.close
  end
end


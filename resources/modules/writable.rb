require 'fileutils'

module Writable
  def write_to_main(new_file_name, new_text)
    FileUtils.cp('./resources/website-template.html', new_file_name)    
    file = open("./" + new_file_name, 'r+:UTF-8')
    content = file.read.sub(/^\s*<!-- INSERT ARTICLES HERE -->/, new_text)
    file.truncate(0)
    file.rewind
    file.write(content)
    file.close
  end

  def write_articles(array_of_articles, to_file, of_n)
    new_file_name = to_file == 0 ? "index.html" : "index-#{to_file}.html"     
    new_text = array_of_articles.flatten.join("\n")
    write_to_main(new_file_name, new_text)
  end

  def write_about_page(to_file, text)
    write_to_main(to_file, text)
  end
end


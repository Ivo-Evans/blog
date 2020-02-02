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
    new_text = array_of_articles.flatten.join("\n")
    write_to_main(name_index_page(to_file), new_text)
  end

  # def write_about_page(to_file, text)
  #   write_to_main(to_file, text)
  # end

  def name_index_page(n)
    n == 0 ? "./pages/index.html" : "/pages/index-#{n}"
  end
end


require 'fileutils'

module Writable
  def write(array_of_articles, to_file)
    new_file_name ="index-#{to_file}.html"     
    FileUtils.cp('./resources/website-template.html', new_file_name)    
    file = open("./" + new_file_name, 'r+:UTF-8')
    new_text = file.read.sub(/^\s*<!-- INSERT ARTICLES HERE -->/, array_of_articles.flatten.join("\n"))
    file.truncate(0)
    file.rewind
    file.write(new_text)
    file.close
  end
end


require './resources/modules/readable'
require './resources/modules/writable'
include Readable
include Writable

def parse_articles
  articles = Dir.entries("./articles/").reject { |f| f == '.' || f == ".."}.sort
  articles.map! { |article| Readable.read("./articles/" + article)}
  Writable.write(articles, 0) # feed it an array articles no longer than 10 so that the page loads fast 
end

parse_articles

# TODO: different page generation
# TODO: if page number == 0, don't name it index-0.html, name it index.html
# TODO: implement automatic page-number navigation. Rename Writable.write to Writable.write_content. Add Writable.write_pagination which opens the file just created by Writable.write_content, and performs another operation on it, adding page numbers and links.
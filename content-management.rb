require './resources/modules/readable'
require './resources/modules/writable'
include Readable
include Writable

def parse_articles
  articles = Dir.entries("./articles/").reject { |f| f == '.' || f == ".."}.sort
  articles.map! { |article| Readable.read("./articles/" + article)}
  Writable.write(articles, 0) # feed it an array articles no longer than 10 so that the page loads fast
  # also write a Readable.get_titles, which gets titles for sidebar, and in Writeable.write, write a populate_sidebar function with a third parameter passed in. 
end

parse_articles
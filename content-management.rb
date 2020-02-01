require './resources/modules/readable'
require './resources/modules/writable'
include Readable
include Writable

def make_website
  parse_articles
  parse_about
end

def parse_articles
  articles = Dir.entries("./content/articles/").reject { |f| f == '.' || f == ".."}.sort
  articles.map! { |article| Readable.read_article("./content/articles/" + article)}
  this_page = 0
  total_pages = articles.length / 10
  Writable.write_articles(articles, this_page, total_pages) # feed it an array articles no longer than 10 so that the page loads fast 
end

def parse_about
  about = read_about('./content/about.txt')
  write_about_page('about.html', about)
end

make_website

# TODO: different page generation
# TODO: if page number == 0, don't name it index-0.html, name it index.html
# TODO: implement automatic page-number navigation. Rename Writable.write to Writable.write_content. Add Writable.write_pagination which opens the file just created by Writable.write_content, and performs another operation on it, adding page numbers and links.
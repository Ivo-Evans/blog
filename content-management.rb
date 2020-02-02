require './resources/modules/readable'
require './resources/modules/compilable'
require './resources/modules/writable'
include Readable
include Compilable
include Writable

def make_website
  article_paths = Dir.entries("./content/articles/").reject { |f| f == '.' || f == ".."}.sort
  parse_articles(article_paths)
  parse_titles(article_paths)
  parse_about
end

def parse_articles(articles)
  articles = articles.map do |article| 
    # Readable.parse_article("./content/articles/" + article)
    string = Readable.read_article("./content/articles/" + article)
    title = Readable.parse_title(string)
    tags = Readable.parse_tags(string)
    date = Readable.parse_date(string)
    content = Readable.parse_content(string)
    Compilable.compile_article(title, tags, date, content)
  end

  this_page = 0
  total_pages = articles.length / 10
  Writable.write_articles(articles, this_page, total_pages) # feed it an array articles no longer than 10 so that the page loads fast 
end

def parse_about
  about = read_article('./content/about.txt')
  Writable.write_to_main('./pages/about.html', about)
  # write_about_page('about.html', about)
end

def parse_titles(articles)
  titles = articles.map { |a| Readable.parse_title(Readable.read_article("./content/articles/" + a)) }
  archive_text = Compilable.compile_archive(titles)
  Writable.write_to_main('./pages/archive.html', archive_text.join("\n"))
  # puts titles # You can then render articles on archive.html. You can use index / 10 to work out which page to link to, availing yoursel of write_to_main. The title of each element should be its id - the thing that links to it on the page. 
end


make_website

# TODO: different page generation
# TODO: if page number == 0, don't name it index-0.html, name it index.html
# TODO: implement automatic page-number navigation. Rename Writable.write to Writable.write_content. Add Writable.write_pagination which opens the file just created by Writable.write_content, and performs another operation on it, adding page numbers and links.
require './resources/modules/readable'
require './resources/modules/compilable'
require './resources/modules/writable'
include Readable
include Compilable
include Writable

def make_website
  article_paths = Dir.entries("./content/articles/").reject { |f| f == '.' || f == ".."}.sort
  make_main_pages(article_paths)
  make_archive(article_paths)
  make_about
end

def make_main_pages(articles)
  articles = articles.map do |article| 
    string = Readable.read_article("./content/articles/" + article)
    title = Readable.parse_title(string)
    tags = Readable.parse_tags(string)
    date = Readable.parse_date(string)
    content = Readable.parse_content(string)
    Compilable.compile_article(title, tags, date, content)
  end

  pages = []
  articles.each_slice(10) { |s| pages.push(s)}
  pages.each_with_index { |e, i| Writable.write_articles(e, i, pages.length)}
end

def make_about
  about = read_article('./content/about.txt')
  Writable.write_to_main('./about.html', about)
  # write_about_page('about.html', about)
end

def make_archive(articles)
  titles = articles.map { |a| Readable.parse_title(Readable.read_article("./content/articles/" + a)) }
  archive_text = Compilable.compile_archive(titles)
  Writable.write_to_main('./archive.html', archive_text.join("\n"))
  # puts titles # You can then render articles on archive.html. You can use index / 10 to work out which page to link to, availing yoursel of write_to_main. The title of each element should be its id - the thing that links to it on the page. 
end


make_website

# TODO: implement automatic page-number navigation. Add another formfield into the html template, and in writable another method, write_pagination, called in write_articles after write_to_main. 
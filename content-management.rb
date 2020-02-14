require './resources/modules/readable'
require './resources/modules/compilable'
require './resources/modules/writable'
include Readable
include Compilable
include Writable

@name_page = lambda { |type, n| n == 0 ? "./#{type}.html" : "./#{type}-#{n}.html" }

def make_website
  article_paths = Dir.entries("./content/articles/").reject { |f| f == '.' || f == ".."}.sort.reverse
  make_article_pages(article_paths)
  make_archive(article_paths)
  make_about
end

def make_article_pages(articles)
  articles = articles.map do |article| 
    article = Readable.parse_article(article)
    Compilable.compile_article(article[0], article[1], article[2], article[3])
  end

  pages = []
  articles.each_slice(10) { |s| pages.push(s)}

  pages.each_with_index do |content, slice_number| 
    Writable.write_articles(content, slice_number, @name_page)
    
    pagination = Compilable.compile_pagination(slice_number, pages.length, @name_page)
    Writable.write_pagination(pagination, slice_number, @name_page)
  end
end

def make_about
  about = Readable.read_article('./content/about.txt')
  Writable.write_to_main('./about.html', about)
  # write_about_page('about.html', about)
end

def make_archive(articles)
  titles = articles.map { |a| Readable.parse_title(Readable.read_article("./content/articles/" + a)) }
  archive_text = Compilable.compile_archive(titles, @name_page)
  Writable.write_to_main('./archive.html', archive_text.join("\n"))
end


make_website


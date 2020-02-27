# frozen_string_literal: true

require './resources/modules/readable'
require './resources/modules/compilable'
require './resources/modules/writable'

# gets filepaths then uses other modules to retrieve, process and write strings to new files
class Manageable
  include Readable
  include Compilable
  include Writable

  def initialize
    @name_page = lambda { |type, n|
      type = type.gsub(/\s+/, '-')
      n.zero? ? "./#{type}.html" : "./#{type}-#{n}.html"
    }
    # Lambda necessary for filenames (Writable) and for links (Compilable)
    # Github pages requires index.html not index-0.html
    @articles_per_page = 5
  end

  def make_website
    article_paths = Dir.entries('./content/articles/').reject { |f| ['.', '..'].include?(f) }.sort.reverse
    articles = article_paths.map { |a| Readable.parse_article(a) }
    # returns tuples like [title, [tag1, tag2], date, [content_line1, content_line2]]
    unique_tags = articles.flat_map { |a| a[1] }.uniq
    make_article_pages(articles, 'index', unique_tags)
    make_tag_pages(articles, unique_tags)
    make_archive(article_paths)
    make_about
  end

  def make_tag_pages(articles, unique_tags)
    tag_collected_articles = unique_tags.each_with_object({}) do |tag, hash|
      hash[tag] = articles.select { |a| a[1].include?(tag) }
    end

    tag_collected_articles.each { |tag, article_set| make_article_pages(article_set, "tag-#{tag}", unique_tags) }
  end

  def make_article_pages(articles, page_type, unique_tags)
    articles = articles.map { |article| Compilable.compile_article(article[0], article[1], article[2], article[3], @name_page) }
    sidebar_content = Compilable.compile_tag_sidebar(unique_tags, @name_page)

    pages = []
    articles.each_slice(@articles_per_page) { |s| pages.push(s) }

    pages.each_with_index do |content, slice_number|
      page_address = @name_page[page_type, slice_number] 
      pagination = Compilable.compile_pagination(slice_number, pages.length, @name_page, page_type)
      
      Writable.write_articles(content, page_address)
      Writable.write_pagination(pagination, page_address)
      Writable.write_tag_sidebar(sidebar_content, page_address)
    end
  end

  def make_archive(articles)
    titles = articles.map { |a| Readable.parse_title(Readable.read_article('./content/articles/' + a)) }
    archive_text = Compilable.compile_archive(titles, @name_page, @articles_per_page)
    Writable.write_to_main('./archive.html', archive_text.join("\n"))
  end

  def make_about
    about = Readable.read_article('./content/about.txt')
    Writable.write_to_main('./about.html', about)
  end
end

Manageable.new.make_website

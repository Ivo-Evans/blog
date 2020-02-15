# frozen_string_literal: true

require './resources/modules/readable'
require './resources/modules/compilable'
require './resources/modules/writable'

# gets filepaths then uses other modules to retrieve, process and write strings to new files
module Manageable
  include Readable
  include Compilable
  include Writable

  @name_page = ->(type, n) { n.zero? ? "./#{type}.html" : "./#{type}-#{n}.html" }
  # needed both to name pages and for links in pages to other pages - so needed in both Writable and Compilable. When type is 'index' this names one of the main flow of pages. When type it "tag#{tag}" this represents a page in an alternate channel, the pages relevant to that particular tag.

  def make_website
    article_paths = Dir.entries('./content/articles/').reject { |f| ['.', '..'].include?(f) }.sort.reverse
    articles = article_paths.map { |a| Readable.parse_article(a) }
    # returns tuples like [title, [tag1, tag2], date, [content_line1, content_line2]]
    make_article_pages(articles, 'index')
    make_tag_pages(articles)
    make_archive(article_paths)
    make_about
  end

  def make_tag_pages(articles)
    unique_tags = articles.flat_map { |a| a[1] }.uniq

    tag_collected_articles = unique_tags.each_with_object({}) do |tag, hash|
      hash[tag] = articles.select { |a| a[1].include?(tag) }
    end

    tag_collected_articles.each { |tag, article_set| make_article_pages(article_set, "tag-#{tag}") }
  end

  def make_article_pages(articles, page_type)
    articles = articles.map { |article| Compilable.compile_article(article[0], article[1], article[2], article[3]) }

    pages = []
    articles.each_slice(10) { |s| pages.push(s) }

    pages.each_with_index do |content, slice_number|
      Writable.write_articles(content, slice_number, @name_page, page_type)

      pagination = Compilable.compile_pagination(slice_number, pages.length, @name_page, page_type)
      Writable.write_pagination(pagination, slice_number, @name_page, page_type)
    end
  end

  def make_about
    about = Readable.read_article('./content/about.txt')
    Writable.write_to_main('./about.html', about)
    # write_about_page('about.html', about)
  end

  def make_archive(articles)
    titles = articles.map { |a| Readable.parse_title(Readable.read_article('./content/articles/' + a)) }
    archive_text = Compilable.compile_archive(titles, @name_page)
    Writable.write_to_main('./archive.html', archive_text.join("\n"))
  end
end

include Manageable
Manageable.make_website

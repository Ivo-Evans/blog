# frozen_string_literal: true

# receives array of strings and returns array of strings in valid HTML
module Compilable
  @tab = '  '

  def self.compile_article(article, namer, format)
    tags = article[:tags].map { |tag| "<a href=\"#{namer["tag-#{tag}", 0]}\">#{tag}</a>"}

    format
      .gsub(/<!-- title -->/, article[:title])
      .sub(/<!-- tags -->/, tags.join(", "))
      .sub(/<!-- date -->/, article[:date])
      .sub(/<!-- content -->/, article[:content].join("\n"))
  end

  def self.compile_archive(titles, namer, articles_per_page)
    titles.each_with_index do |e, i|
      titles[i] = @tab * 2 + "<p><a class=\"archive-link\"href=\"#{namer['index', i / articles_per_page]}##{e}\">#{e}</a></p>"
    end
  end

  def self.compile_tag_sidebar(tags, namer)
    sidebar = [
      '<aside>',
      @tab + '<nav>',
      @tab * 2 + '<h3>tags</h3>',
    ]

    tags = tags.each do |tag| 
      new_line = @tab * 2 + "<p><a href=\"#{namer["tag-#{tag}", 0]}\">#{tag}</a></p>"\
      # provisionally, it seems that syntax highlighting is wrong here and the method is fine. 
      sidebar.push(new_line)
    end

    sidebar + [
      @tab + '</nav>',
      '</aside>'
    ]
  end

  def self.compile_pagination(this_n, total_n, namer, page_type)
    (0..total_n - 1).map do |e|
      address = namer[page_type, e]
      if e == this_n
        @tab * 3 + "<h3><a class=\"current-page\" href=\"#{address}\">#{e}</a></h3>"
      else
        @tab * 3 + "<h3><a class=\"non-current-page\" href=\"#{address}\">#{e}</a></h3>"
      end
    end
  end
end

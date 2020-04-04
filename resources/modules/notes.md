CMS.rb

-> initialize -> @article_format = Readable.read_article('./templates/article.html') # should be renamed to read_file

-> make_article_pages -> Compilable.compile_articles extra param, @article_format

Compilable.rb

# maybe Readable.parse_article should return a hash rather than an array. It would be better later

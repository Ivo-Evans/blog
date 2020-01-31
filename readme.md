## The content management system

Rather than writing new articles directly to any html, you should add plaintext files to ./articles, and then run content-management.rb. This will generate new html files named index-n.html. index-0.html will always be the homepage.

### naming articles
By convention, articles begin with a number from 000 to 999, followed by the title of the article, where 000 is the first-written article and 999 is the last-written article. Starting with the numbers lets content-management.rb retain the order in which articles were written, but you can use any notation you want. 

The program is not picky about filetypes for the articles. html files, txt files, and files with no extension at all are all acceptable. It is important, however, that you format their contents correctly.

### formatting articles
Plaintext article files shoud be formatted as so

```
title: Your Title
tags: comma separated, tags
date: nn/nn/nn or in fact any text you like

CONTENT
<p> this is where you place the article contents</p>

<p>Write valid html here</p>
CONTENT
```

"title: ", "tag: " and "date: " must start a line and be lower case. Matching will occur from the ": " to the end of that line.

content matching works differently. 
* For CONTENT markers to be matched they need to be on their own lines. 
* Matching is greedy: it matches all text between the first and last valid CONTENT marker, so you may use the word CONTENT freely within the first and the last valid marker. 
* You should manually write the html tags inside the CONTENT markers, due to the variability in tags you might want to use to make your article text. 
* Distinct HTML tags should be separated by one empty line, as above.
* The first layer of indentation, like these p tags, should be flush with the margin. 
* The tabbing style applied by content-management.rb is two spaces. This can be changed by changing the tab variable in the method compile(), inside ./resources/modules/readable.rb

### making changes to the rest of the page

content-management.rb uses a template to generate page elements other than articles, ./resources/website-template.html

Therefore, If you want to make a change to the website other than adding an article, you should make it here, then compile the website again with content-management.rb. Make sure not to change the line that says

```
        <!-- INSERT ARTICLES HERE -->
```

content-management.rb needs it!
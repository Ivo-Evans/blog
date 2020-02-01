## The content management system

All changes to html should be implemented through content-management.rb

### adding articles

Rather than writing new articles directly to any html, you should add plaintext files to ./articles, and then run content-management.rb. This will generate new html files named index-n.html. index-0.html will always be the homepage.

#### Naming articles
By convention, articles begin with a number from 000 to 999, followed by the title of the article, where 000 is the first-written article and 999 is the last-written article. Starting with the numbers lets content-management.rb retain the order in which articles were written, but you can use any notation you want. 

The program is not picky about filetypes for the articles. html files, txt files, and files with no extension at all are all acceptable. It is important, however, that you format their contents correctly.

#### Formatting articles
Plaintext article files shoud be formatted as so

```
title: Your Title
tags: comma separated, tags
date: nn/nn/nn or in fact any text you like

CONTENT
<p> this is where you place the article contents</p>

<p>You should write valid HTML</p>
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

### Making changes to the page's HTML other than adding articles

content-management.rb uses a template, found in ./resources/website-template.html, to generate the page and then inserts article elements into this new page.

Therefore, If you want to make a change to the website other than adding an article, you should make it to website-template.html, then compile the website again with content-management.rb. Make sure not to change the line that says

```
        <!-- INSERT ARTICLES HERE -->
```

content-management.rb needs it!


### Making changes to the HTML markup for articles

To do this you have to edit the content management system itself. This will probably mean editing the module Readable, found in ./resources/modules/readable.rb. This contains a method called compile() which takes data harvested from an article file and returns an array of html elements. If you want to do something like change the order of html elements, this would be the place to do it. 
const titles = Array.from(document.body.querySelectorAll('.post-title'))
const sidebar = document.body.querySelector('.sidebar')

titles.forEach(title => {
  let paragraph = document.createElement('P');
  let link = document.createElement('A');
  link.setAttribute('href', '#' + title.id);
  link.innerText = title.id;
  console.log(link);
  paragraph.appendChild(link);
  sidebar.appendChild(paragraph);
})
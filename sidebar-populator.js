const titles = Array.from(document.body.querySelectorAll('.post-title'))
const sidebar = document.body.querySelector('.sidebar')

titles.forEach(title => {
  let link = document.createElement('A');
  console.log(link);
  link.setAttribute('href', '#' + title.id);
  link.innerText = title.id;
  // let text = document.createTextNode(title.id);
  // console.log(text);
  // link.appendChild(text);
  // console.log(link.href);
  sidebar.appendChild(link);
})
let posts = document.querySelectorAll('.post');
posts = Array.from(posts).map((post) => [...post.getElementsByTagName('p'), ...post.getElementsByTagName('h4')]);

posts.forEach(post => {
  if (post[1]) {
    // post[1].addEventListener('click', () => expand(post[0]));
    post[1].addEventListener('click', () => expandOrContract(post))
  }
})

function expandOrContract(post) {
  if (Array.from(post[1].classList).includes('more')) { // this classList based solution is actually superfluous. You could just read the innerText...
    post[1].innerText = 'Read less -';
    expand(post[0]);
  } else if (Array.from(post[1].classList).includes('less')) {
    post[1].innerText = 'Read more +';
    contract(post[0]);
  }

  post[1].classList.toggle('more'); // it would actually be quite cool if these happened after it finished. The innertText changes would have to happen after that too. You could use setTimeout
  post[1].classList.toggle('less');
}

function expand(postContent) {
  let currentHeight = 6;
  let finish = 100; // I would very much like to not have to hardcode this, for obvious reasons... so how about this. It's a bit of a longage. If offsetheight on a given interval == offsetHeight on the last interval, clearInterval and record current height in such a way that it's available to contract; then I have the currentHeight at which expand stopped, and can go back down from that.

  let expansion = setInterval(
    function() {
      currentHeight++
      postContent.style.maxHeight = currentHeight + "em";
      console.log(postContent.offsetHeight);
      // console.log(currentHeight);
      if (currentHeight >= finish) {clearInterval(expansion)}
    },
    20);
}

/* 
A plan:
- when I map through post, make the first value 6
- pass post to expand and contract, rather than an index of post
- inside expand, create a variable called recordedHeight, initialised to post[2].offsetHeight
- iterate post[0], increment and assign this to post[2].style.maxHeight
- on each incrementation, you should check whether post[2].offsetHeight >= recordedHeight
- if it is, stop incrementing. If it isn't, update recordedHeight and keep incrementing.

*/

function contract(postContent) {
  let currentHeight = 100; // problematic;
  let finish = 6;
  
  let contraction = setInterval(() => {
    currentHeight--;
    postContent.style.maxHeight = currentHeight + "em";
    console.log(currentHeight);
    if (currentHeight <= finish) {clearInterval(contraction)}  
  }, 
  20);
}

// function getLineHeight(element){
//   var temp = document.createElement(element.nodeName);
//   temp.setAttribute("style","margin:0px;padding:0px;font-family:"+element.style.fontFamily+";font-size:"+element.style.fontSize);
//   temp.innerHTML = "test";
//   temp = element.parentNode.appendChild(temp);
//   var ret = temp.clientHeight;
//   temp.parentNode.removeChild(temp);
//   return ret;
// }
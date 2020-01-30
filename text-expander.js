const startHeight = 4; // number of lines - sync to maxHeight and minHeight ems in CSS
const scrollSpeed = 20; // approx ms between each line being added/removed

let posts = Array.from(document.querySelectorAll('.post')).map((post) => {
  return {
    height: startHeight,
    content: post.querySelector('.post-content'),
    button: post.querySelector('.expandContractButton')
  }
})

posts.forEach(post => {
  if (post.button) {
    post.button.addEventListener('click', () => {
      if (post.button.innerText == "Read more +") {
        expand(post);
      } else if (post.button.innerText == "Read less -") {
        contract(post);
      }
    })
  }
})

function expand(post) {
  let recordedHeight = post.content.offsetHeight;

  let expansion = setInterval(() => {
    post.height++;
    post.content.style.maxHeight = post.height + "em";
    if (post.content.offsetHeight == recordedHeight) {
      clearInterval(expansion);
      post.button.innerText = "Read less -"; 
    } else {
      recordedHeight = post.content.offsetHeight;
    }
  }, scrollSpeed);
}

function contract(post) {
  let contraction = setInterval(() => {
    post.height--;
    post.content.style.maxHeight = post.height + "em";
    if (post.height <= startHeight) {
      clearInterval(contraction);
      post.button.innerText = "Read more +";
    }
  }, scrollSpeed)
}
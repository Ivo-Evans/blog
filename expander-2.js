let posts = Array.from(document.querySelectorAll('.post')).map((post) => 
    [
      6, // starting lineheight - see CSS
      post.querySelector('.post-content'), // this strategy relies on having only one p element - actually quite implausible. Better, I think, to target the div with the class post-content
      post.querySelector('.expandContractButton')
    ]
  
)

posts.forEach(post => {
  if (post[2]) {
    post[2].addEventListener('click', () => expandOrContract(post))
  };
})

function expandOrContract(post) {
  if (post[2].innerText == 'Read more +') {
    expand(post);
    post[2].innerText = "Read less -"; // could put a setTImeout to change this in expand
  } else if (post[2].innerText == "Read less -") {
    contract(post);
    post[2].innerText = "Read more +";
  }
}

function expand(post) {
  let recordedHeight = post[1].offsetHeight;

  let expansion = setInterval(() => {
    post[0]++;
    post[1].style.maxHeight = post[0] + "em";
    if (post[1].offsetHeight == recordedHeight) {
      clearInterval(expansion)
    } else {
      recordedHeight = post[1].offsetHeight;
    }
  }, 20);
}

function contract(post) {
  let contraction = setInterval(() => {
    post[0]--;
    post[1].style.maxHeight = post[0] + "em";
    if (post[0] <= 6) {clearInterval(contraction)}
  }, 20)
}
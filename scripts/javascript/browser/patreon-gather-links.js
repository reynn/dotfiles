function continuousClick(className) {
  let e = document.getElementsByClassName(className)
  console.log('Found ' + e.length + ' buttons')
  for (let i = 0; i < e.length; i++) {
    const button = e[i];
    console.log('clicking ' + button.id)
    button.click()
    e = document.getElementsByClassName(className)
  }
  return e.length
}

function getPosts() {
  let ret = []
  let posts = document.getElementsByTagName('div')
  for (let i = 0; i < posts.length; i++) {
    const element = posts[i];
    if (element.hasAttribute('data-tag') && element.getAttribute('data-tag') == 'post-card')
      ret.push({
        'id': getPostID(element),
        'imgs': getImages(element),
        'title': getTitle(element),
        'content': getContent(element),
        'tags': getTags(element),
        'attachments': getAttachments(element)
      })
  }
  return ret
}

function getPostID(e) {
  let t = e.getElementsByClassName("s1x7bffp-1 jegpgD")
  if (t.length < 1) {
    return ''
  }
  let link = t[0].getElementsByTagName('a')[0].getAttribute('href')
  let splitLink = link.split('-')
  return splitLink[splitLink.length - 1]
}

function getTitle(e) {
  let t = e.getElementsByClassName('s1x7bffp-1 jegpgD')
  return t[0] ? t[0].innerText : ''
}

function getAttachments(e) {
  var attaches = []
  let arr = e.getElementsByClassName('sc-cSHVUG gEiLXQ')
  for (let i = 0; i < arr.length; i++) {
    const element = arr[i];
    let links = element.getElementsByTagName('a')
    for (let ii = 0; ii < links.length; ii++) {
      const link = links[ii];
      attaches.push(link.getAttribute('href'))
    }
  }
  return attaches
}

function getContent(e) {
  let divs = e.getElementsByTagName('div')
  for (let i = 0; i < divs.length; i++) {
    const element = divs[i];
    if (
      element.hasAttribute('data-tag') &&
      (element.getAttribute('data-tag') == 'post-content' || element.getAttribute('data-tag') == 'post-content-collapse')
    ) {
      return element.innerText
    }
  }
}

function getTags(e) {
  let divs = e.getElementsByTagName('div')
  for (let i = 0; i < divs.length; i++) {
    const element = divs[i];
    if (element.hasAttribute('data-tag') && element.getAttribute('data-tag') == 'post-tags') {
      return element.innerText.split(',')
    }
  }
}

function getImages(e) {
  let imgs = []
  let ee = e.getElementsByTagName('img')
  console.log('imgs : ' + ee)
  for (let i = 0; i < ee.length; i++) {
    const element = ee[i];
    imgs.push(element.getAttribute('src'))
  }
  return imgs
}

function displayPosts(array) {
  console.log(JSON.stringify(array))
}

// clicker = setInterval(function () {
// let e = continuousClick('sc-kkGfuU cDImvh');
// if (e == 0) {
// clearInterval(clicker)
displayPosts(getPosts('sc-cSHVUG gOQcte'))
// }
// }, 4000);

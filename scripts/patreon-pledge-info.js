creatorsArr = document.getElementsByClassName('sc-cSHVUG gHtjiI')
creators = []
for (let ci = 0; ci < creatorsArr.length; ci++) {
  const creator = creatorsArr[ci];

  let name = creator.getElementsByClassName('sc-cSHVUG jGNxBm')[0].textContent
  let ammount = creator.getElementsByClassName('sc-cSHVUG eujfai')[0].textContent
  creators.push({
    'name': name,
    'ammount': ammount
  })
}
console.log(JSON.stringify(creators))

var inputs = document.getElementsByTagName('input');
for (let i = 0; i < inputs.length; i++) {
  const element = inputs[i];
  if (element.hasAttribute('checked')) {
    console.log('element.clicked: ' + element.parentElement.parentElement.textContent);
    element.click();
  }
}

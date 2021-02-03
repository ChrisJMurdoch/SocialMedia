//https://www.youtube.com/watch?v=5L6h_MrNvsk followed this tutorial for tabs

const tabs = document.querySelectorAll('[data-tab-target]')
const tabContents = document.querySelectorAll('[tab-pane]')


tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    const target = document.querySelector(tab.dataset.tabTarget)
    tabContents.forEach(tabContent => {
      tabContent.classList.remove('active')
    })
    tabs.forEach(tab => {
      tab.classList.remove('active')
    })
    tab.classList.add('active')
    target.classList.add('active')
  })
})


window.onload = function () {

  // fanBtn.onclick = function () {
  //   cont.style.display = 'none'
  //   fans.style.display = 'none'
  // }

  Followers.onclick = function () {
    cont.style.display = 'block'
    fans.style.display = 'block'
  }
  Following.onclick = function () {
    cont.style.display = 'block'
    Focus.style.display = 'block'
  }
  FocusCloseBtn.onclick = function () {
    cont.style.display = 'none'
    Focus.style.display = 'none'
    // tabs[0].classList.add('active')
    // console.log(tabContents[0])
    // tabContent[0].classList.remove('active')
  }

  for (var i = 0; i < Focusbtn.length; i++) {
    Focusbtn[i].index = i;
    Focusbtn[i].onclick = function () {
      // .
      for (let j = 0; j < Focusitems.length; j++) {
        Focusitems[j].style.display = 'none'
        Focusbtn[j].classList.remove('focusActive')

      }
      Focusbtn[this.index].classList.add('focusActive')

      Focusitems[this.index].style.display = 'block'

      console.log(Focusitems[this.index])
    }
  }

}

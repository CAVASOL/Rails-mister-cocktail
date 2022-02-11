const searchScroll = () => {
  document.addEventListener("scroll", e => {
    const searchContainer = document.querySelector(".search-container");
    const banner = document.querySelector(".banner");
    // console.log(window.scrollY)
    // console.log(banner.offsetHeight)
    if (searchContainer && banner) {
      if ((window.scrollY + 160) > banner.offsetHeight) {
        searchContainer.style.top = 0;
        searchContainer.classList.add("search-container-back")
      } else {
        if (window.scrollY === 0) {
          searchContainer.style.top = "160px";
        }
        searchContainer.classList.remove("search-container-back")
      }
    }
  })

}

export { searchScroll }

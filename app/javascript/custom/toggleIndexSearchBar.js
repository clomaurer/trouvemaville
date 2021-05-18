const indexShow = () => {
  const navbar = document.querySelector(".navbar-lewagon")
  const indexSearchBar = document.getElementById('index-search-bar');
  if(indexSearchBar) {

    navbar.addEventListener('mouseenter', (e) => {
      indexSearchBar.classList.remove('hide-search-bar')
    })
   indexSearchBar.addEventListener('mouseleave', (e) => {
      indexSearchBar.classList.add('hide-search-bar')
  })
  }
};

export { indexShow };

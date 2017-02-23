$(document).ready(function() {
 var $grid = $('.grid').masonry({
    itemSelector: '.grid-item',
    percentPosition: true,
    columnWidth: 260,
    gutter: 30,
    });
  $('.grid').imagesLoaded().progress( function() {
      $grid.masonry('layout');
   });
})
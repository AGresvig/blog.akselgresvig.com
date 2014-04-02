/** 
* This script is loaded on page load. Checks if we have a "comments" holder tag
* on the page, and if so declares a scroll listener to load comments when the reader
* reaches bottom of the article.
**/
$(function() {
  var disqus_div = $("#disqus_thread");
  //If we dont have the div on the page, then abort
  if(!disqus_div.length) return; 

  var disqus_developer = 1,
      disqus_url = 'http://blog.akselgresvig.com',
      top = disqus_div.offset().top, // When to start loading
      ds_loaded = false;
  
  if(!disqus_div) return; //If we dont have the div on the page, then abort

  if (disqus_div.children().length) {
      ds_loaded = true;
  }

  var loadWidget = function() {
    $.ajax({
      type: "GET",
      url: "http://akselgresvig.disqus.com/embed.js",
      dataType: "script",
      cache: true
    })
      .done(function( script, textStatus ) {
        console.log( textStatus );
      })
      .fail(function( jqxhr, settings, exception ) {
        console.log("Unable to load disqus comments. Exception:");
        console.log(exception);
      });
  };

  var check = function() {
    if ( !ds_loaded && $(window).scrollTop() + $(window).height() > top ) {
      ds_loaded = true;    
      loadWidget();
    }
  };

  $(window).scroll(check);
});
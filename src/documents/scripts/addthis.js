/**
* Loads AddThis sharing widget if were on a "posts/" sub-url
*/
$(function() {
  if(window.location.href.indexOf("posts/") > -1) {
    //Go to http://www.addthis.com/get/smart-layers to customize
    $.getScript("//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-52939001482d1b04")
      .fail(function () {
        console.log("Unable to fetch AddThis widget");
      })
      .done(function() {
        addthis.layers({
          'theme' : 'transparent',
          'share' : {
            'position' : 'left',
            'numPreferredServices' : 5,
            'offset': {'bottom': '210px'}
          }   
        });
      });
  }
});
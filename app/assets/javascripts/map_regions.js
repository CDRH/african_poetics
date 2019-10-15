$(document).ready(function() {

  // TODO pull the link from the search results instead to overlay on the map
  // but for now, using this to construct the query if user clicks the map
  var urlpiece = "../search?f[]=keywords|"
  
  /////////////
  // HELPERS //
  /////////////

  function getRegionCodeFromClass(classes) {
    if (classes) {
      // TODO this will not aswork if diaspora is somehow represented on the map
      var region = classes.match(/\S*_Africa/g)
      return region ? region[0] : null
    }
  }

  function getRegionCodeFromText(text, replace_char="_") {
    return text ? text.trim().replace(" ", replace_char) : null;
  }

  function getRegionTextFromCode(text) {
    return text ? text.replace("_", " ") : null;
  }

  ///////////////////////////////////
  // HOVER OVER SEARCH RESULT TEXT //
  ///////////////////////////////////

  $("td.index_name > a").hover(
    function () {
      var regionCode = getRegionCodeFromText($(this).text());
      $( "svg ." + regionCode).addClass("country_highlight");
      $(this).addClass("element_hover");
    },
    function () {
      var regionCode = getRegionCodeFromText($(this).text());
      $( "svg ." + regionCode).removeClass("country_highlight");
      $(this).removeClass("element_hover");
    }
  );

  ////////////////////
  // HOVER OVER MAP //
  ////////////////////

  // Highlight region name and other countries when hovering over any part of a region
  $("svg > g > path, svg > g > g").hover(
    function () {
      var regionCode = getRegionCodeFromClass($(this).attr("class"));
      var regionName = getRegionTextFromCode(regionCode);
      $(".index_name > a:contains(" + regionName + ")").addClass("element_hover");
      $("."+regionCode).addClass("svg_hover");
    },
    function () {
      var regionCode = getRegionCodeFromClass($(this).attr("class"));
      var regionName = getRegionTextFromCode(regionCode);
      $(".index_name > a:contains(" + regionName + ")").removeClass("element_hover");
      $("."+regionCode).removeClass("svg_hover");
    }
  );

  //////////////////
  // CLICK ON MAP //
  //////////////////

  $("svg path").click(function() {
    var regionCode = getRegionCodeFromClass($(this).attr("class"));
    var regionName = getRegionTextFromCode(regionCode);
    var href = getRegionCodeFromText(regionName, "+");
    var fullurl = urlpiece + href;
    window.location = fullurl;  
  });

});

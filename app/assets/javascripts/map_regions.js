$(document).ready(function() {

  /////////////
  // HELPERS //
  /////////////

  function getRegionCodeFromClass(classes) {
    if (classes) {
      // TODO this will not work if diaspora is somehow represented on the map
      var region = classes.match(/\S*_Africa/g)
      return region ? region[0] : null
    }
  }

  function getRegionCodeFromText(text, replace_char) {
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
      var regionCode = getRegionCodeFromText($(this).text(), "_");
      $( "svg ." + regionCode).addClass("country_highlight");
      $(this).addClass("element_hover");
    },
    function () {
      var regionCode = getRegionCodeFromText($(this).text(), "_");
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
    if (search_path) {
      // if a search_path variable was provided, use that
      var fullurl = search_path + "?region=" + href;
    } else {
      // if no search_path variable provided, default to
      // the contemporary african poets search
      var urlpiece = "../search?f[]=keywords|";
      var fullurl = urlpiece + href;
    }
    window.location = fullurl;  
  });

});

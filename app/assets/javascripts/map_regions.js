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

  // North Africa -> North_Africa or North+Africa, etc
  function getRegionCodeFromText(text, replace_char) {
    return text ? text.trim().replace(" ", replace_char) : null;
  }

  // North_Africa -> North Africa
  function getRegionTextFromCode(text) {
    // substitute region text for the correct API query
    // currently this is unnecessary
    // if (text === "North_Africa") {
    //   text = "Northern_Africa"
    // } else if (text === "East_Africa") {
    //   text = "Eastern_Africa"
    // } else if (text === "West_Africa") {
    //   text = "Western_Africa"
    // }
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

  // create links for the regions to search results
  //   - CAP uses different path structure than the In the News section
  //   - In the News needs to provide "search_path" variable, since
  //     there are many different possible subjects (poets, events, works, etc)
  $("#regions_map svg path").click(function() {
    var regionCode = getRegionCodeFromClass($(this).attr("class"));
    var regionName = getRegionTextFromCode(regionCode);
    var href = getRegionCodeFromText(regionName, "+");

    // in the news
    if (typeof search_path !== 'undefined') {
      var fullurl = search_path + "?f[]=spatial.region|" + href;
    // CAP
    } else {
      var fullurl = "../search?f[]=keywords|"+href;
    }
    window.location = fullurl;  
  });

});

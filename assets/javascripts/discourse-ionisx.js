$(function () {
  $("#site-logo").prop("src", Discourse.SiteSettings.ionisx_logo_url);
  var framed = window.top !== window;

  if (framed) {
    $(".d-header").hide();
    $("#main-outlet").css("padding-top","0");
  }
});

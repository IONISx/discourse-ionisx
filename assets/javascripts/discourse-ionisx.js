$(function () {
  $("#site-logo").prop("src", "./images/logo-ionisx.png");
  var framed = window.top !== window;

  if (framed) {
    $(".d-header").hide();
    $("#main-outlet").css("padding-top","0");
  }
});

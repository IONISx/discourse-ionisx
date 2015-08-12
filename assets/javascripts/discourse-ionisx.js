$(function () {
  var framed = window.top !== window;

  if (framed) {
    $(".d-header").hide();
    $(".ember-view .category-breadcrumb").hide();
    $("#main-outlet").addClass("framed");
    $("#navigation-bar").hide();
    $(".alert-info").hide();
  }
});

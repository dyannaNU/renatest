(function() {
  "use strict";

  document.addEventListener("turbolinks:load", function setPostForm() {
    var $form = $("form");
    var EXIT_BUTTON_ATTR = "[rel='redirect_home']";

    function postForm(event) {
      event.preventDefault();

      var HIDDEN_FIELD_ID = "#redirect_home";
      var URL = $form.attr("action");

      $form.find(HIDDEN_FIELD_ID).val(true);
      $.post(URL, $form.serialize());
    };

    $form.on("click", EXIT_BUTTON_ATTR, postForm);
  });
}());

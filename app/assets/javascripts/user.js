(function(global) {
    function form() {
        var storyForm = $("form#new_story_event");

        function authToken() {
            return storyForm.find('input[name="authenticity_token"]').val()
        }

        function participantId() {
            return storyForm.find("#story_event_participant").val();
        }

        function route() {
            return storyForm.attr("action");
        }

        function routeOrigin() {
          return global.location.origin
        }

        return {
            authToken: authToken(),
            routeOrigin: routeOrigin(),
            route: route()
        }
    };

    function saveModule(event) {
      var $form = form();
      var data = event.data;

      if (data && data.story_event && event.origin === $form.routeOrigin) {
        $.post($form.route, {
            authenticity_token: $form.authToken,
            story_events: {
                story_identifier: event.data.id
            }
        });
      }
    }

    global.addEventListener("message", saveModule, false);
}(window));

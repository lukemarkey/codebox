<script>

document.addEventListener("DOMContentLoaded", function(event) {
    (function($) {

        mapElements = document.querySelectorAll("a[href*='google.com/maps/place/']");
        phoneElements = document.querySelectorAll("a[href*='tel:']");
        emailElements = document.querySelectorAll("[href*='mailto:']");
        formElements = document.querySelectorAll("form");

        console.log(formElements);
        console.log(mapElements);
        console.log(phoneElements);
        console.log(emailElements);

        for(let element of formElements) {

            element.addEventListener('submit', function(form) {
                var label = (element.getAttribute('id')) ? element.getAttribute('id') : document.title;
                console.log('label: ' + label);
                console.log('form: ' + form);
                console.log('form event started');
                gtag('event', 'Form' {
                  event_category: 'Submission',
                  event_label: label,
                  value: 50
                });
                console.log('form event finished');
                console.log('form element submitted');
            });
        }

        for(let element of mapElements) {
            element.addEventListener('click', function() {
                var eventLabel = element.getAttribute('href').split('https://www.google.com/maps/place/')[1].split('/@')[0];
                console.log(eventLabel);
                console.log('event started');
                gtag('event', 'Map' {
                  event_category: 'Link',
                  event_label: eventLabel,
                  value: 10
                });
                console.log('event finished');
            });
        }

        for(let element of phoneElements) {
            element.onclick = function() {
                var eventLabel = element.getAttribute('href').split(':')[1];
                console.log(eventLabel);
                console.log('event started 2');
                gtag('event', 'Phone' {
                  event_category: 'Link',
                  event_label: eventLabel,
                  value: 25
                });
                console.log('event finished');
            }
        }

        for(let element of emailElements) {
            element.onclick = function() {
                var eventLabel = element.getAttribute('href').split(':')[1];
                console.log(eventLabel);
                console.log('event started');

                gtag('event', 'Email' {
                  event_category: 'Link',
                  event_label: eventLabel,
                  value: 25
                });

                console.log('event finished');
            }
        }

    })(jQuery);
});



</script>

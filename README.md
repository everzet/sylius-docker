Very basic Docker setup for Sylius
==================================

This is the most basic baseline setup I could've come up with for getting Sylius working locally via
Docker. It was tested extensively in Docker for Mac, but should technically work with other
installations.

Word of caution
---------------

This setup should be used as a baseline, not an end of itself. Please do not use it as is in
production as there are changes you are expected to do inside `Dockerfile` in order to secure your
code and data, particularly first lines of the file - environment variables.

Quirks
------

- Default environment is `dev`
- Accessing `/app_dev.php` is allowed by default
- HTTPS is enforced, Certificate is automatically generated
- `vendor/` and `var/` folders arent shared with the local system

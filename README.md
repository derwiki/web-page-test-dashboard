# Web Page Test Dashboard
This Ruby on Rails project is a wrapper around the Web Page Test API that
provides:
- a dashboard view of performance tests
- a rake task to run performance tests and record them
- easily deployable to Heroku

![Example Chart](https://rawgit.com/derwiki/web-page-test-dashboard/master/screenshot-chart.jpg)

### Pre-requisites
1. **Web Page Test API Key**
http://www.webpagetest.org/getkey.php

### Installation
1. `git clone git@github.com:derwiki/web-page-test-dashboard.git`
1. `cd web-page-test-dashboard`
1. `heroku create web-page-test-dashboard-my-project.herokuapp.com`
1. `git push heroku master`
1. `heroku run rake db:migrate`
1. `heroku restart`
1. `heroku addons:install scheduler`
1. `heroku addons:open scheduler` and add `rake wpt:run` every ten minutes (will run 5 times)

### Configuration
Load `http://web-page-test-dashboard-my-project.herokuapp.com/targets/new` and
add a script for the page you want to load:

Example script:
```
navigate https://my-project.com
setValue name=username johndoe123
setValue name=password s3cur3
setEventName submitLogin
clickAndWait value=Sign In
```

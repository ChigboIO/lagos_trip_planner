# Lagos Trip Planner


Welcome to Lagos trip Planner. This utility basically helps users to determine the most efficient route to take while traversing locations in Lagos State.

## Usage

* Ensure you have ruby installed on your local machine
* Clone this repository.
* Run ```bundle install```
* Then you fire up your rails server
* Visit your localhost's url and then watch the app in action.

You will not need to run any migrations to initialize your database. The data used comes straight out of the box.

All you will need to do is to enter a depature location in Lagos State and then a Destination Location and then you will be presented with the route to take.

## Limitations

* This app is not yet live on production

* There are currently no test suites for this app
* There are limited requests to the google distance matrix api so we had to use multiple api keys to make the required requests. We had to trim down the number of requests we made and we also assumed that any two locations that are more than 10 km apart do not have a direct connecting road. All of these factors affect the correctness of the results.




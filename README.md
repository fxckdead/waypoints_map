# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:


## Live Demo https://beetrack.staytrue.cl
-----


## Prerequisites

The setups steps expect following tools installed on the system.

- Git  [2.x](https://git-scm.com/)
- Ruby [2.6.1](https://www.ruby-lang.org/)
- Rails [6.0.3](https://rubyonrails.org/)
- Redis
- PostgreSQL

##### 1. Check out the repository

```bash
git clone git@github.com:fxckdead/beetrack_gps_tracker.git
```

##### 2. Install project dependencies

```bash
bundle install
```

##### 3. Install JS dependencies

Install Javascript dependencies running this command on the project folder

```bash
yarn

or

npm
```

##### 4. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:setup
```



##### 5. Start Sidekiq 

To proccess waypoints need to start sidekiq with this command

```ruby
bundle exec sidekiq
```
You will get access to Sidekiq GUI at http://localhost:3000/sidekiq

##### 6. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```
And now you can visit the site with the URL http://localhost:3000

-----

## Running Tests

On the root folder use this command

```bash
rspec
```

-----

# Using the API

If you want to use the API to add waypoints you must made a `POST` request to http://localhost:3000/api/v1/gps with the Waypoint structure as JSON:

#### Single waypoint

```json
{
  "latitude": 20.23,
  "longitude": -0.56,
  "sent_at": "202020-06-02 20:45:00",
  "vehicle_identifier": "HA-3452"
}
```

#### Array of waypoints
```json
[
    {
        "latitude": -33.404483,
        "longitude": -70.723242,
        "sent_at": "2020-07-02 20:48:00",
        "vehicle_identifier": "R2D2"
    },
    {
        "latitude": -33.404483,
        "longitude": -70.723242,
        "sent_at": "2020-09-05 20:48:00",
        "vehicle_identifier": "ATAT"
    }
]
```

You can use [Postman](https://www.postman.com/) or with cURL at commando line:

```bash
curl -XPOST -H "Content-type: application/json" -d \
'{
    "latitude": -33.404483,
    "longitude": -70.723242,
    "sent_at": "2020-07-02 20:48:00",
    "vehicle_identifier": "R2D2"
 }' 'http://localhost:3000/api/v1/gps'
```
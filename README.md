# Coffee Club

This application allows team members to review the coffee on offer in the Abletech kitchen.

[![Build Status](https://travis-ci.org/AbleTech/coffee-club.svg?branch=master)](https://travis-ci.org/AbleTech/coffee-club)

## Installation

1. Fork this repo
2. Clone into a local directory
3. Change to your new local directory
4. `bundle install`
5. `rails server`

## Usage
To vote, visit [Abletech's Slack channel](https://abletech.slack.com). To upvote a coffee, use the command `/coffee good` or `/coffee +1`. To downvote a coffee use the command `/coffee bad` or `/coffee -1`. Your vote will be recorded and the dashboard will be updated. Every time a new batch of coffee is in the kitchen, a notification will be sent to the [#Coffee-Club-Bot](https://abletech.slack.com/messages/C841JS933) channel.

## Building/Deploying UAT:
    git checkout develop
    git pull origin develop
    rails s
  
## Building/Deploying PRODUCTION:
    git checkout master
    git pull origin master
    git push heroku master
    heroku config:set ADMIN_USERNAME=admin
    heroku config:set ADMIN_PASSWORD=coffee
    heroku config:set SLACK_URL=<PUT SLACK URL HERE>

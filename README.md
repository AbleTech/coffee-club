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
To vote, visit your organisation's Slack channel. To upvote a coffee, use the command `/coffee good` or `/coffee +1`. To downvote a coffee use the command `/coffee bad` or `/coffee -1`. Your vote will be recorded and the dashboard will be updated. Every time a new batch of coffee is in the kitchen, a notification will be sent to the requested Slack Channel.

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
    
## Setting up Slack Integration
In order to setup Slack integration, you will need to setup the slash commands (i.e. /coffee) and setup an incoming webhook for the application to send out notifications.

1. Visit https://api.slack.com and setup an application.
2. Enable **Incoming Webhooks** and get the webhook URL for the channel you want the notifications to be sent to (this will be the value for the environment variable for the SLACK_URL above).
3. Under Slash Commands create a new command `/coffee` with the request URL `your.heroku.domain/votes`

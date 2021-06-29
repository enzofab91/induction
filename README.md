# README

## Introduction
This app is a Ruby on Rails API developed to obtain experience in backend development with Ruby. The idea behind Target is that a user could talk with another, who is in a certain distance, about a topic they choose.

The app is hosted in Heroku: https://target-induction.herokuapp.com
The admin can be access here: https://target-induction.herokuapp.com/admin

The default credentials are admin@example.com/password.

## Basic Flow
  1. A user creates a Target
  2. Another user creates a target that is the same topic as the first one and is inside the distance specified.
  3. A match is created and they are now able to chat.

## Features

- Users
  - Create account
  - Login with mail
  - Login with facebook
  - Update account
  - Reset password
- Target
  - Create target (Maximum of 10)
  - List all created targets
  - Delete target
- Conversations
  - List conversations
  - Receive notifications when a conversation that involves me was created
  - Show unread messages indicator
- Messages
  - Receive notifications when someone messages me
  - List messages of a conversation

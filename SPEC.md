# Hunt

House-hunting for pros. This is more or less just ramblings at this point but maybe a good starting place.

## Tech

Basics:

- Node.js
- Express
- Angular
- Passport for auth?
- Jade
- Stylus + Nib
- CoffeeScript

MongoDB (eugh) or Postgres or MySQL or something else?

## Users

Users can log in via some means (maybe social sign in via Facebook/Twitter?) and are given a profile of some description, to start off with just name/email.

Users can enter location of their workplace so we can be smart about calculating routes to work from potential properties (via CityMapper?)

## Hunts

A user can start a hunt (essentially a search for a property), supplying some rough criteria which we then match properties up to. They can add other users (their FB friends if we're doing Facebook sign-in, perhaps?). They can also add properties.

## Properties

Properties are added to the hunt by the user - they can either manually enter details (maybe put in a postcode/street/property name?) or we can scrape Rightmove/Zoopla/certain estate agent websites. From here, we can pull in lots of metadata about the area and property... maybe:

- average prices based on property stats
- nearby transport, routes to work
- broadband speed
- crime rates
- council tax
- if we know sq footage of house, maybe potential heating/electricity costs?
- nearby shit to do (yplan/yelp?)
- (need more ideas)

You can upload photos... if you upload geotagged photos maybe it can automatically figure out which property to go to? If we've scraped photos from agent then split them up between agent/user submitted
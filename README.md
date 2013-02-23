# DiyApi

A Ruby interface to the DIY.org API. According to the ["About" page](https://diy.org/about):

> DIY is a community where young people become Makers. They discover new Skills, make projects in the real world, and share their work online to inspire and learn from each other.

## Setup

1. [Request an API key](http://friends.diy.org/developers) from DIY.

2. Include the gem in your project.

    Once the `diy_api` library covers all functionality detailed in the API's [developer documentation](http://friends.diy.org/developers), it will go up on RubyGems.org. In the meantime, you can include the gem in your project like so:

	  Add this line to your application's Gemfile:

	    gem 'diy_api', :git => 'git://github.com/dianakimball/diy_api.git'

	  And then execute:

	    bundle install

## Configuration

All requests require an API key; you can [request a key](http://friends.diy.org/developers) as described in [Setup](http://github.com/dianakimball/diy_api#setup). Once you have a key in hand, you can configure an API client in a single line:

    client = DIY::Client.new('your-api-key')

User-authenticated requests are not yet supported by the wrapper, though I intend to add that functionality in the future.

## Usage Examples

_A note on array requests:_

When making calls that return arrays, it is possible to set limits and pagination. DIY.org's current default limit (mirrored in the defaults set by the wrapper) is 100 results per call.

Limits and pagination are currently available on the following methods: `projects`, `explore`, `skills`, and `tools`.

### Makers

#### Fetch a Maker (by ID)

    client.maker(37614)

#### Fetch a Stream (by Maker ID)

The DIY API allows for grabbing a stream of "activity related to a given maker" _or_ "followed makers' activity." In short, stuff related to a maker or stuff related to the makers that a given maker follows." In this gem, we'll call "stuff related to a maker" the "action stream" and "stuff related to the makers that a given maker follows" the "activity stream."

    client.action_stream(37614) # returns activity related to maker 37614
    client.activity_stream(37614) # returns activity related to the makers that maker 37614 follows

#### Fetch a Maker's Projects (by Maker ID)

    client.projects_by_maker(37614)

#### Fetch a Maker's Achievements (by Maker ID)

    client.achievements_by_maker(37614)

#### Fetch a Maker's Favorites (by Maker ID)

    client.favorites_of_maker(37614)

#### Fetch a Maker's Followers (by Maker ID)

Makers who have chosen to follow the given maker.

    client.followers_of_maker(37614)

#### Fetch a Maker's Follows (by Maker ID)

Makers whom the given maker has chosen to follow.

    client.follows_of_maker(37614)

### Projects

#### Fetch a Project (by ID)

    client.project(868)

#### Fetch Comments on a Project (by Project ID)

    client.comments_on_project(868)

#### Fetch Projects

    client.projects # returns the first 100 projects across the entire site
    client.projects(limit: 200) # returns the first 200 projects across the entire site
    client.projects(limit: 200, offset: 200) # returns the second 200 projects across the entire site

#### Fetch Projects Featured on the ["Explore" page](https://diy.org/explore)

    client.explore # returns the first 100 featured projects across the entire site
    client.explore(limit: 200) # returns the first 200 featured projects across the entire site
    client.explore(limit: 200, offset: 200) # returns the second 200 featured projects across the entire site

### Skills

#### Fetch a Skill (by ID)

    client.skill(79)

#### Fetch the Challenges for a Skill (by Skill ID)

    client.challenges_for_skill(79)

#### Fetch Skills

_Note: as of February 2013, there are fewer than 100 skills total._

    client.skills # returns up to 100 skills across the entire site
    client.skills(limit: 15) # returns the first 15 skills across the entire site
    client.skills(limit: 15, offset: 15) # returns the second 15 skills across the entire site

### Tools

#### Fetch a Tool (by ID)

    client.tool(46)

#### Fetch Tools

    client.tools # returns the first 100 tools across the entire site
    client.tools(limit: 200) # returns the first 200 tools across the entire site
    client.tools(limit: 200, offset: 200) # returns the second 200 tools across the entire site

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

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

#### Fetch a Maker (by ID)

    client.maker(37614)
    
#### Fetch a Project (by ID)

    client.project(868)
    
#### Fetch a Skill (by ID)

    client.skill(79)
    
#### Fetch a Tool (by ID)

    client.tool(46)

### Array Requests

When making calls that return arrays, it is possible to set limits and pagination. DIY.org's current default limit (mirrored in the defaults set by the wrapper) is 100 results per call. 
    
#### Fetch Projects

    client.projects # returns the first 100 projects
    client.projects(limit: 200) # returns the first 200 projects
    client.projects(limit: 200, offset: 200) # returns the second 200 projects
    
#### Fetch Projects Featured on the ["Explore" page](https://diy.org/explore)

    client.explore # returns the first 100 featured projects
    client.explore(limit: 200) # returns the first 200 featured projects
    client.explore(limit: 200, offset: 200) # returns the second 200 featured projects
    
#### Fetch Skills

_Note: as of February 2013, there are fewer than 100 skills total._

    client.skills # returns up to 100 skills
    client.skills(limit: 15) # returns the first 15 skills
    client.skills(limit: 15, offset: 15) # returns the second 15 skills 
    
#### Fetch Tools

    client.tools # returns the first 100 tools
    client.tools(limit: 200) # returns the first 200 tools
    client.tools(limit: 200, offset: 200) # returns the second 200 tools
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

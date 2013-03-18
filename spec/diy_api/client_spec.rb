require 'helper'

describe DIY::Client do

  before do
    @client = DIY::Client.new('abc123')
  end

  describe "#initialize" do

    before do
      @client = DIY::Client.new('abc123', 'username', 'password')
    end

    it "initializes an object" do
      expect(@client).to be_kind_of DIY::Client
    end

    it "sets the API key as an instance variable" do
      api_key = @client.instance_variable_get(:"@api_key")
      expect(api_key).to eq 'abc123'
    end

    it "sets the username as an instance variable" do
      username = @client.instance_variable_get(:"@username")
      expect(username).to eq 'username'
    end

    it "sets the password as an instance variable" do
      password = @client.instance_variable_get(:"@password")
      expect(password).to eq 'password'
    end

    it "sets the API version as an instance variable" do
      api_version = @client.instance_variable_get(:"@api_version")
      expect(api_version).to eq '~1.4'
    end
  end

  describe "#maker" do

    before do
      stub_request(:get, "https://api.diy.org/makers/37614").to_return(:body => fixture('maker.json'))
    end

    it "requests the correct resource" do
      @client.maker(37614)
      expect(a_request(:get, "https://api.diy.org/makers/37614")).to have_been_made
    end

    it "returns the requested maker" do
      maker = @client.maker(37614)
      expect(maker).to be_a Hashie::Mash
      expect(maker.nickname).to eq "goldenrod"
    end
  end

  describe "#action_stream" do

    before do
      stub_request(:get, "https://api.diy.org/makers/37614/stream").to_return(:body => fixture('action_stream.json'))
    end

    it "requests the correct resource" do
      @client.action_stream(37614)
      expect(a_request(:get, "https://api.diy.org/makers/37614/stream")).to have_been_made
    end

    it "returns the requested action stream" do
      action_stream = @client.action_stream(37614)
      expect(action_stream).to be_an Array
      expect(action_stream.first).to be_a Hashie::Mash
      expect(action_stream.first.object.project.achievement.challenge.id).to eq 275
    end
  end

  describe "#activity_stream" do

    before do
      stub_request(:get, "https://api.diy.org/makers/37614/following/stream").to_return(:body => fixture('activity_stream.json'))
    end

    it "requests the correct resource" do
      @client.activity_stream(37614)
      expect(a_request(:get, "https://api.diy.org/makers/37614/following/stream")).to have_been_made
    end

    it "returns the requested activity stream" do
      activity_stream = @client.activity_stream(37614)
      expect(activity_stream).to be_an Array
      expect(activity_stream.first).to be_a Hashie::Mash
      expect(activity_stream.first.object.favorite.id).to eq 45339
    end
  end

  describe "#projects_by_maker" do

    before do
      stub_request(:get, "https://api.diy.org/makers/37614/projects").to_return(:body => fixture('projects_by_maker.json'))
    end

    it "requests the correct resource" do
      @client.projects_by_maker(37614)
      expect(a_request(:get, "https://api.diy.org/makers/37614/projects")).to have_been_made
    end

    it "returns the requested projects by maker" do
      projects_by_maker = @client.projects_by_maker(37614)
      expect(projects_by_maker).to be_an Array
      expect(projects_by_maker.first).to be_a Hashie::Mash
      expect(projects_by_maker.first.id).to eq "001176"
    end
  end

  describe "#achievements_by_maker" do

    before do
      stub_request(:get, "https://api.diy.org/makers/304/achievements").to_return(:body => fixture('achievements_by_maker.json'))
    end

    it "requests the correct resource" do
      @client.achievements_by_maker(304)
      expect(a_request(:get, "https://api.diy.org/makers/304/achievements")).to have_been_made
    end

    it "returns the requested achievements by maker" do
      achievements_by_maker = @client.achievements_by_maker(304)
      expect(achievements_by_maker).to be_a Hashie::Mash
      expect(achievements_by_maker.activity).to be_an Array
      expect(achievements_by_maker.activity.first.challenge_id).to eq 837
    end
  end

  describe "#favorites_of_maker" do

    before do
      stub_request(:get, "https://api.diy.org/makers/37614/favorites").to_return(:body => fixture('favorites_of_maker.json'))
    end

    it "requests the correct resource" do
      @client.favorites_of_maker(37614)
      expect(a_request(:get, "https://api.diy.org/makers/37614/favorites")).to have_been_made
    end

    it "returns the requested favorites of maker" do
      favorites_of_maker = @client.favorites_of_maker(37614)
      expect(favorites_of_maker).to be_an Array
      expect(favorites_of_maker.first).to be_a Hashie::Mash
      expect(favorites_of_maker.first.achievement.challenge.id).to eq 166
    end
  end

  describe "#followers_of_maker" do

    before do
      stub_request(:get, "https://api.diy.org/makers/37614/followers").to_return(:body => fixture('followers_of_maker.json'))
    end

    it "requests the correct resource" do
      @client.followers_of_maker(37614)
      expect(a_request(:get, "https://api.diy.org/makers/37614/followers")).to have_been_made
    end

    it "returns the requested followers of maker" do
      followers_of_maker = @client.followers_of_maker(37614)
      expect(followers_of_maker).to be_an Array
      expect(followers_of_maker.first).to be_a Hashie::Mash
      expect(followers_of_maker.first.id).to eq 5
    end
  end

  describe "#follows_of_maker" do

    before do
      stub_request(:get, "https://api.diy.org/makers/37614/following").to_return(:body => fixture('follows_of_maker.json'))
    end

    it "requests the correct resource" do
      @client.follows_of_maker(37614)
      expect(a_request(:get, "https://api.diy.org/makers/37614/following")).to have_been_made
    end

    it "returns the requested follows of maker" do
      follows_of_maker = @client.follows_of_maker(37614)
      expect(follows_of_maker).to be_an Array
      expect(follows_of_maker.first).to be_a Hashie::Mash
      expect(follows_of_maker.first.id).to eq 5
    end
  end

  describe "#project" do

    before do
      stub_request(:get, "https://api.diy.org/projects/000ulo").to_return(:body => fixture("project.json"))
    end

    it "requests the correct resource" do
      @client.project("000ulo")
      expect(a_request(:get, "https://api.diy.org/projects/000ulo")).to have_been_made
    end

    it "returns the requested project" do
      project = @client.project("000ulo")
      expect(project).to be_a Hashie::Mash
      expect(project.title).to eq "Crochet Beach Rocks"
    end
  end

  describe "#comments_on_project" do

    before do
      stub_request(:get, "https://api.diy.org/projects/000ulo/comments").to_return(:body => fixture('comments_on_project.json'))
    end

    it "requests the correct resource" do
      @client.comments_on_project("000ulo")
      expect(a_request(:get, "https://api.diy.org/projects/000ulo/comments")).to have_been_made
    end

    it "returns the requested comments on project" do
      comments_on_project = @client.comments_on_project("000ulo")
      expect(comments_on_project).to be_an Array
      expect(comments_on_project.first).to be_a Hashie::Mash
      expect(comments_on_project.first.id).to eq 27761
    end
  end

  describe "#projects" do

    context "with default limit and offset" do

      before do
        stub_request(:get, "https://api.diy.org/projects").
          with(:query => {:limit => "100", :offset => "0"}).
          to_return(:body => fixture('projects.json'))
      end

      it "requests the correct resource" do
        @client.projects
        expect(a_request(:get, "https://api.diy.org/projects").
          with(:query => {:limit => "100", :offset => "0"})).
          to have_been_made
      end

      it "returns the requested projects" do
        projects = @client.projects
        expect(projects).to be_an Array
        expect(projects.count).to be <= 100
        expect(projects.first).to be_a Hashie::Mash
        expect(projects.first.id).to eq "0015b4"
      end
    end

    context "with limit of 200 and offset of 0" do

      before do
        stub_request(:get, "https://api.diy.org/projects").
          with(:query => {:limit => "200", :offset => "0"}).
          to_return(:body => fixture('projects.json'))
      end

      it "requests the correct resource" do
        @client.projects(limit: 200, offset: 0)
        expect(a_request(:get, "https://api.diy.org/projects").
          with(:query => {:limit => "200", :offset => "0"})).
          to have_been_made
      end
    end

    context "with limit of 50 and offset of 50" do

      before do
        stub_request(:get, "https://api.diy.org/projects").
          with(:query => {:limit => "50", :offset => "50"}).
          to_return(:body => fixture('projects.json'))
      end

      it "requests the correct resource" do
        @client.projects(limit: 50, offset: 50)
        expect(a_request(:get, "https://api.diy.org/projects").
          with(:query => {:limit => "50", :offset => "50"})).
          to have_been_made
      end
    end
  end

  describe "#skill" do

    before do
      stub_request(:get, "https://api.diy.org/skills/79").to_return(:body => fixture('skill.json'))
    end

    it "requests the correct resource" do
      @client.skill(79)
      expect(a_request(:get, "https://api.diy.org/skills/79")).to have_been_made
    end

    it "returns the requested skill" do
      skill = @client.skill(79)
      expect(skill).to be_a Hashie::Mash
      expect(skill.title).to eq "Yeti"
    end
  end

  describe "#challenges_for_skill" do

    before do
      stub_request(:get, "https://api.diy.org/skills/79/challenges").to_return(:body => fixture('challenges_for_skill.json'))
    end

    it "requests the correct resource" do
      @client.challenges_for_skill(79)
      expect(a_request(:get, "https://api.diy.org/skills/79/challenges")).to have_been_made
    end

    it "returns the requested challenges for skill" do
      challenges_for_skill = @client.challenges_for_skill(79)
      expect(challenges_for_skill).to be_an Array
      expect(challenges_for_skill.first).to be_a Hashie::Mash
      expect(challenges_for_skill.first.id).to eq 683
    end
  end

  describe "#skills" do

    context "with default limit and offset" do

      before do
        stub_request(:get, "https://api.diy.org/skills").
          with(:query => {:limit => "100", :offset => "0"}).
          to_return(:body => fixture('skills.json'))
      end

      it "requests the correct resource" do
        @client.skills
        expect(a_request(:get, "https://api.diy.org/skills").
          with(:query => {:limit => "100", :offset => "0"})).
          to have_been_made
      end

      it "returns the requested skills" do
        skills = @client.skills
        expect(skills).to be_an Array
        expect(skills.count).to be <= 100
        expect(skills.first).to be_a Hashie::Mash
        expect(skills.first.title).to eq "Animator"
      end
    end

    context "with limit of 15 and offset of 0" do

      before do
        stub_request(:get, "https://api.diy.org/skills").
          with(:query => {:limit => "15", :offset => "0"}).
          to_return(:body => fixture('skills.json'))
      end

      it "requests the correct resource" do
        @client.skills(limit: 15, offset: 0)
        expect(a_request(:get, "https://api.diy.org/skills").
          with(:query => {:limit => "15", :offset => "0"})).
          to have_been_made
      end
    end

    context "with limit of 30 and offset of 30" do

      before do
        stub_request(:get, "https://api.diy.org/skills").
          with(:query => {:limit => "30", :offset => "30"}).
          to_return(:body => fixture('skills.json'))
      end

      it "requests the correct resource" do
        @client.skills(limit: 30, offset: 30)
        expect(a_request(:get, "https://api.diy.org/skills").
          with(:query => {:limit => "30", :offset => "30"})).
          to have_been_made
      end
    end
  end

  describe "#tool" do

    before do
      stub_request(:get, "https://api.diy.org/tools/46").to_return(:body => fixture('tool.json'))
    end

    it "requests the correct resource" do
      @client.tool(46)
      expect(a_request(:get, "https://api.diy.org/tools/46")).to have_been_made
    end

    it "returns the requested tool" do
      tool = @client.tool(46)
      expect(tool).to be_a Hashie::Mash
      expect(tool.title).to eq "Paper"
    end
  end

  describe "#tools" do

    context "with default limit and offset" do
      before do
        stub_request(:get, "https://api.diy.org/tools").
          with(:query => {:limit => "100", :offset => "0"}).
          to_return(:body => fixture('tools.json'))
      end

      it "requests the correct resource" do
        @client.tools
        expect(a_request(:get, "https://api.diy.org/tools").
          with(:query => {:limit => "100", :offset => "0"})).
          to have_been_made
      end

      it "returns the requested tools" do
        tools = @client.tools
        expect(tools).to be_an Array
        expect(tools.count).to be <= 100
        expect(tools.first).to be_a Hashie::Mash
        expect(tools.first.title).to eq "2-Liter Bottle"
      end
    end

    context "with limit of 200 and offset of 0" do

      before do
        stub_request(:get, "https://api.diy.org/tools").
          with(:query => {:limit => "200", :offset => "0"}).
          to_return(:body => fixture('tools.json'))
      end

      it "requests the correct resource" do
        @client.tools(limit: 200, offset: 0)
        expect(a_request(:get, "https://api.diy.org/tools").
          with(:query => {:limit => "200", :offset => "0"})).
          to have_been_made
      end
    end

    context "with limit of 50 and offset of 50" do

      before do
        stub_request(:get, "https://api.diy.org/tools").
          with(:query => {:limit => "50", :offset => "50"}).
          to_return(:body => fixture('tools.json'))
      end

      it "requests the correct resource" do
        @client.tools(limit: 50, offset: 50)
        expect(a_request(:get, "https://api.diy.org/tools").
          with(:query => {:limit => "50", :offset => "50"})).
          to have_been_made
      end
    end
  end

  describe "#explore" do

    context "with default limit and offset" do

      before do
        stub_request(:get, "https://api.diy.org/explore").
          with(:query => {:limit => "100", :offset => "0"}).
          to_return(:body => fixture('explore.json'))
      end

      it "requests the correct resource" do
        @client.explore
        expect(a_request(:get, "https://api.diy.org/explore").
          with(:query => {:limit => "100", :offset => "0"})).
          to have_been_made
      end

      it "returns the requested explore results" do
        explore = @client.explore
        expect(explore).to be_an Array
        expect(explore.count).to be <= 100
        expect(explore.first).to be_a Hashie::Mash
        expect(explore.first.title).to eq "Spore Print"
      end
    end

    context "with limit of 200 and offset of 0" do

      before do
        stub_request(:get, "https://api.diy.org/explore").
          with(:query => {:limit => "200", :offset => "0"}).
          to_return(:body => fixture('explore.json'))
      end

      it "requests the correct resource" do
        @client.explore(limit: 200, offset: 0)
        expect(a_request(:get, "https://api.diy.org/explore").
          with(:query => {:limit => "200", :offset => "0"})).
          to have_been_made
      end
    end

    context "with limit of 50 and offset of 50" do

      before do
        stub_request(:get, "https://api.diy.org/explore").
          with(:query => {:limit => "50", :offset => "50"}).
          to_return(:body => fixture('explore.json'))
      end

      it "requests the correct resource" do
        @client.explore(limit: 50, offset: 50)
        expect(a_request(:get, "https://api.diy.org/explore").
          with(:query => {:limit => "50", :offset => "50"})).
          to have_been_made
      end
    end
  end
end

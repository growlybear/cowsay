require 'rack/test'
require 'cow'

set :environment, :test

describe "The Cow app" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "generates a cow" do
    expected = (<<'END').strip
 _______
< Hello >
 -------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
END

    get '/'

    last_response.should be_ok

    result = last_response.body.strip.gsub(/\s*\n/, "\n")
    result.should eq(expected)
  end

  it "uses the message parameter if supplied" do
    expected = (<<'END').strip
 ___________
< Good bye! >
 -----------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
END

    get '/', "message" => "Good bye!"

    last_response.should be_ok

    result = last_response.body.strip.gsub(/\s*\n/, "\n")
    result.should eq(expected)
  end
end

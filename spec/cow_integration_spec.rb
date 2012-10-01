require 'rack/test'
require 'sinatra'
require 'json'
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

  it "accepts a cowfile parameter" do
    expected = (<<'END').strip
 _______
< Hello >
 -------
\                             .       .
 \                           / `.   .' "
  \                  .---.  <    > <    >  .---.
   \                 |    \  \ - ~ ~ - /  /    |
         _____          ..-~             ~-..-~
        |     |   \~~~\.'                    `./~~~/
       ---------   \__/                        \__/
      .'  O    \     /               /       \  "
     (_____,    `._.'               |         }  \/~~~/
      `----.          /       }     |        /    \__/
            `-.      |       /      |       /      `. ,~~|
                ~-.__|      /_ - ~ ^|      /- _      `..-'
                     |     /        |     /     ~-.     `-. _  _  _
                     |_____|        |_____|         ~ - . _ _ _ _ _>
END
    get '/', 'cowfile' => "stegosaurus"

    last_response.should be_ok

    result = last_response.body.strip.gsub(/\s*\n/, "\n")
    result.should eq(expected)
  end

  describe "/cowfiles" do
    def do_request
      get '/cowfiles'
    end

    it "returns cowfiles with a JSON content type" do
      do_request
      last_response.content_type.should match(/application\/json/)
    end

    it "returns a list of available cowfiles in JSON" do
      do_request
      result = JSON.parse(last_response.body)
      result.should eq(%w[

        beavis.zen bud-frogs bunny cheese cower daemon default dragon
        dragon-and-cow elephant elephant-in-snake eyes ghostbusters
        hellokitty kitty koala kosh luke-koala meow milk moofasa moose
        ren sheep skeleton small stegosaurus stimpy
        three-eyes turkey turtle tux udder vader
        vader-koala www

      ])
    end
  end
end

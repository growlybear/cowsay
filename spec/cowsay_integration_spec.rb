require 'cowsay'

describe "a cow object" do
  subject { Cowsay.new_cow }

  describe "#say" do
    it "should return an ascii cow" do
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
      # so ... there's two hours of my life I'll never get back :-(
      result = subject.say("Hello").strip.gsub(/\s*\n/, "\n")
      result.should eq(expected)
    end
  end
end

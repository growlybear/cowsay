require 'cowsay'

describe "Cow" do
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
      cow = Cow.new
      # so ... there's two hours of my life I'll never get back :-(
      result = cow.say("Hello").strip.gsub(/\s*\n/, "\n")

      result.should eq(expected)
    end
  end
end

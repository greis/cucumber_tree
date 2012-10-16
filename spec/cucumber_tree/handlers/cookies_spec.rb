require 'cucumber_tree/handlers/cookies'

describe CucumberTree::Handler::Cookies do

  let(:world) { stub(:world, page: page) }
  let(:page) { stub(:page, cookies: cookies) }
  let(:handler) { described_class.new(world) }

  describe "#load" do
    let(:cookies) { {} }
    let(:snapshot) { {cookies: {a: 1} } }

    before { handler.load(snapshot) }

    it "sets the cookies in the page" do
      page.cookies.should == {a: 1}
    end
  end

  describe "#save" do
    let(:cookies) { {a: 1} }
    let(:snapshot) { {} }

    before { handler.save(snapshot) }

    it "sets the cookies in the snapshot" do
      snapshot[:cookies].should == {a: 1}
    end

  end
end

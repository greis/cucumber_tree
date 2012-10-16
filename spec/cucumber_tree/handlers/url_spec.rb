require 'cucumber_tree/handlers/url'

describe CucumberTree::Handler::Url do

  let(:world) { stub(:world, page: page) }
  let(:handler) { described_class.new(world) }

  describe "#load" do
    let(:page) { stub(:page) }
    let(:snapshot) { {url: '/url'} }

    it "visits the url" do
      page.should_receive(:visit).with('/url')
      handler.load(snapshot)
    end
  end

  describe "#save" do
    let(:page) { stub(:page, current_path: '/url' ) }
    let(:snapshot) { {} }

    before { handler.save(snapshot) }

    it "sets the current url in the snapshot" do
      snapshot[:url].should == '/url'
    end
  end
end

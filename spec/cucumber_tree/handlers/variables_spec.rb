require 'cucumber_tree/handlers/variables'

describe CucumberTree::Handler::Variables do

  let(:world) { Object.new }
  let(:handler) { described_class.new(world) }

  describe "#load" do
    let(:snapshot) { {variables: {'@num' => 1} } }

    before { handler.load(snapshot) }

    it "sets the instance variables in the world" do
      world.instance_variable_get('@num').should == 1
    end
  end

  describe "#save" do
    let(:snapshot) { {} }
    let(:instance_variable_name) { "@num" }

    before do
      world.instance_variable_set(instance_variable_name, 1)
      handler.save(snapshot)
    end

    it "sets the variables in the snapshot" do
      snapshot[:variables].should == {'@num' => 1}
    end

    context "with excluded instance variable name" do
      let(:instance_variable_name) { "@app" }

      it "does not set the variable in the snapshot" do
        snapshot[:variables].should == {}
      end
    end
  end
end

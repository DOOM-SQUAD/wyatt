require 'spec_helper'

describe Wyatt::Record do
  
  describe ".add_field_to_class" do

    let(:record) { Wyatt::Record.new }

    let(:field_name) { "foo" }
    let(:type)       { String }

    let(:accessor) { field_name.to_sym }
    let(:mutator)  { "#{field_name}=".to_sym }

    let(:argument)     { "bar" } 
    let(:bad_argument) { Array.new }

    let(:error) { Wyatt::Exceptions::InvalidType }

    before do
      Wyatt::Record.add_field_to_class(field_name, type)
    end

    it "should respond to a new accessor" do
      record.should respond_to(accessor)
    end

    it "should respond to a new mutator" do
      record.should respond_to(mutator)
    end

    it "should assign and fetch data from an instance" do
      record.send(mutator, argument)
      record.send(accessor).should == argument
    end

    it "should raise an exception on incorrect data type" do
      expect { record.send(mutator, bad_argument) }.to raise_error(error)
    end

  end

end

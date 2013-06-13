require 'spec_helper'

describe Wyatt::Core::Record do
  
  describe ".add_field_to_class" do

    let(:record) { Wyatt::Core::Record.new }

    let(:field_name)    { "foo" }
    let(:allowed_types) { [String] }
    let(:remote_type)   { "text" }

    let(:accessor)               { field_name.to_sym }
    let(:mutator)                { "#{field_name}=".to_sym }
    let(:allowed_types_accessor) { "#{field_name}_allowed_types".to_sym }
    let(:remote_type_accessor)   { "#{field_name}_remote_type".to_sym }

    let(:argument)     { "bar" } 
    let(:bad_argument) { Array.new }

    let(:error) { Wyatt::Exceptions::InvalidType }

    before do
      Wyatt::Core::Record.add_field_to_class(field_name, allowed_types, remote_type)
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

    it "should produce list of allowed types" do
      record.send(allowed_types_accessor).should == allowed_types
    end

    it "should produce the remote type" do
      record.send(remote_type_accessor).should == remote_type
    end

  end

end

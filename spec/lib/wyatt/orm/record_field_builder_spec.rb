require 'spec_helper'

describe Wyatt::Core::ORM::RecordFieldBuilder do

  let(:builder_class)    { Wyatt::Core::ORM::RecordFieldBuilder }
  let(:builder)          { builder_class.new(record_class, name, data) }
  let(:record_class)     { record_namespace.const_get(record_constant) }
  let(:record_namespace) { Wyatt::Core::ORM }
  let(:record_constant)  { 'TestRecord' }
  let(:name)             { 'field_name' }
  let(:data)             { 'field_value' }

  before { stub_const("#{record_namespace}::#{record_constant}", Class.new) }

  describe ".define_field" do

    let(:builder_mock) { mock }

    before { builder_class.stub(:new).and_return(builder_mock) }

    it "should instantiate self and call methods" do
      builder_mock.should_receive(:eval_prototypes)

      builder_class.define_field(record_class, name, data)
    end

  end

  describe "#initialize" do
    it "should assign record class" do
      builder.record_class.should == record_class
    end

    it "should assign name" do
      builder.name.should == name
    end

    it "should assign data" do
      builder.data.should == data
    end
  end

  describe "#prototypes" do

    let(:prototypes) do
      [ 
        :accessor_prototype, :mutator_prototype, 
        :label_prototype, :allowed_types_prototype, 
        :remote_type_prototype 
      ]
    end


    it "returns an array of prototype methods" do
      builder.prototypes.should == prototypes
    end
  end

  describe "#define_method" do

    let(:prototype_method) { :arbitrary_prototype }
    let(:prototype_string) { "this is totally valid ruby code" }

    before do
      builder.stub(prototype_method).and_return(prototype_string)
    end

    it "should call class_eval with the results of the given prototype method" do
      builder.record_class.should_receive(:class_eval).once.with(prototype_string)
      builder.define_method(prototype_method)
    end

  end

  context "prototype integrations" do

    let(:record)        { record_class.new }
    let(:test_value)    { 'test value' }
    let(:label)         { 'Test Value' }
    let(:allowed_types) { [String] }
    let(:remote_type)   { 'some ERP field' }

    let(:accessor_method)      { name.to_sym }
    let(:mutator_method)       { "#{name}=".to_sym }
    let(:label_method)         { "#{name}_label".to_sym }
    let(:allowed_types_method) { "#{name}_allowed_types".to_sym }
    let(:remote_type_method)   { "#{name}_remote_type".to_sym }

    before do
      builder.stub(:label).and_return(label)
      builder.stub(:allowed_types).and_return(allowed_types)
      builder.stub(:remote_type).and_return(remote_type)
    end

    describe "accessor and mutator" do

      before do
        builder.define_method(:accessor_prototype)
        builder.define_method(:mutator_prototype)
      end

      it "should repond to an accessor" do
        record.should respond_to(accessor_method)
      end

      it "should respond to a mutator" do
        record.should respond_to(mutator_method)
      end

      it "should be able to set and retrieve a piece of data" do
        record.send(mutator_method, test_value)
        record.send(accessor_method).should == test_value
      end

    end

    describe "label" do

      before do
        builder.define_method(:label_prototype)
      end

      it "should repond to a label accessor" do
        record.should respond_to(label_method)
      end

      it "should return the servie's label for the field" do
        record.send(label_method).should == label
      end

    end

    describe "allowed_types" do

      before do
        builder.define_method(:allowed_types_prototype)
      end

      it "should respond to allowed_types" do
        record.should respond_to(allowed_types_method)
      end

      it "should return the allowed_types array" do
        record.send(allowed_types_method).should == allowed_types
      end

    end

    describe "remote_type" do

      before do
        builder.define_method(:remote_type_prototype)
      end

      it "should respond to remote_type" do
        record.should respond_to(remote_type_method)
      end

      it "should return the remote_type value" do
        record.send(remote_type_method).should == remote_type
      end

    end

  end

end

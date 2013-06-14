require 'spec_helper'                                                            
                                                                                 
describe Wyatt::Core::ORM::RecordClassBuilder do

  let(:builder_class)    { Wyatt::Core::ORM::RecordClassBuilder }
  let(:builder)          { builder_class.new(record_name, schema_file_path) }
  let(:record_constant) { record_namespace.const_get(classified_name) }

  let(:record_namespace) { ::Wyatt::Core::ORM }

  let(:record_name)      { 'test_record_name' }
  let(:schema_file_path) { '/tmp/test.yml' }

  let(:field_name)       { "field" }
  let(:field_data)       { { 'value_key' => 'value' } }
  let(:raw_yaml_string)  { "#{field_name}:\n  value_key: value" }
  let(:field_hash)       { { field_name => field_data } }

  let(:classified_name)  { "TestRecordName" }

  describe ".define_record" do

    let(:builder_mock) { mock }

    before { builder_class.stub(:new).and_return(builder_mock) }

    it 'should call stuff in order' do
      builder_mock.should_receive(:parse_yaml).ordered.once
      builder_mock.should_receive(:define_class_constant).ordered.once
      builder_mock.should_receive(:add_fields).ordered.once
      builder_class.define_record(record_name, schema_file_path)
    end

  end

  describe "#initialize" do

    before do
      builder_class.any_instance.stub(:classify_record_name).and_return(classified_name)
    end

    it "should set record_name" do
      builder.record_name.should == record_name
    end

    it "should set schema_file_path" do
      builder.schema_file_path.should == schema_file_path
    end

    it "should set record class name" do
      builder.record_class_name.should == classified_name
    end

  end

  describe "#classify_record_name" do
    it "should classify the record name" do
      builder.classify_record_name.should == classified_name
    end
  end

  describe "#parse_yaml" do

    before do
      File.stub(:read) { raw_yaml_string }
      YAML.stub(:load) { field_hash }
      builder.parse_yaml
    end

    it "should set raw_yaml_string" do
      builder.raw_yaml_string.should == raw_yaml_string
    end

    it "should set field_hash" do
      builder.field_hash.should == field_hash
    end

  end

  describe "#define_class_constant" do

    before { builder.define_class_constant }

    it "should define an appropriately namespaced constant" do
      expect { record_constant }.to_not raise_error
    end

  end

  describe "#add_fields" do

    before do
      stub_const("#{record_namespace}::#{classified_name}", Class.new)
      builder.stub(:field_hash).and_return(field_hash)
      builder.stub(:record_class).and_return(record_constant)
    end

    it "should call RecordFieldBuilder" do
      Wyatt::Core::ORM::RecordFieldBuilder.should_receive(:define_field)
        .with(record_constant, field_name, field_data)
      builder.add_fields
    end

  end
                                                                                 
end                                                             

require 'spec_helper'

describe Wyatt::Core::Configuration do

  let(:file_path) { "/path/to/file.yml" }

  describe '.load!' do

    let(:core_settings) { 'hello' }
    let(:settings)      { { Wyatt::Core::Configuration::CORE_SETTINGS => core_settings } }

    it 'should initialize the value of file_path' do
      Wyatt::Core::Configuration.stub(:read_yaml) { settings }
      Wyatt::Core::Configuration.load!(file_path)

      Wyatt::Core::Configuration.file_path.should eq(file_path)
    end

    it 'should call read_yaml' do
      Wyatt::Core::Configuration.should_receive(:read_yaml).once.and_return(settings)
      Wyatt::Core::Configuration.load!(file_path)
    end

    it 'should initialize core_settings with the value of the core key' do
      Wyatt::Core::Configuration.stub(:read_yaml) { settings }
      Wyatt::Core::Configuration.load!(file_path)

      Wyatt::Core::Configuration.core_settings.should eq(core_settings)
    end

  end

  describe '.read_yaml' do

    let(:raw_yaml_string) { "this is totally valid yaml" }

    before do
      Wyatt::Core::Configuration.stub(:file_path) { file_path }
    end

    it 'should call IO.read with the file path' do
      YAML.stub!(:load)

      IO.should_receive(:read).once.with(file_path)
      Wyatt::Core::Configuration.read_yaml
    end

    it 'should call YAML::load with the results of IO.read' do
      IO.stub!(:read) { raw_yaml_string }

      YAML.should_receive(:load).once.with(raw_yaml_string)
      Wyatt::Core::Configuration.read_yaml
    end

  end

end

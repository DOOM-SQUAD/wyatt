require 'spec_helper'

describe Wyatt::Configuration do

  let(:file_path) { "/path/to/file.yml" }

  describe '.load!' do

    let(:core_settings) { 'hello' }
    let(:settings)      { { Wyatt::Configuration::CORE_SETTINGS => core_settings } }

    it 'should initialize the value of file_path' do
      Wyatt::Configuration.stub(:raw_settings) { settings }
      Wyatt::Configuration.load!(file_path)

      Wyatt::Configuration.file_path.should eq(file_path)
    end

    it 'should call raw_settings' do
      Wyatt::Configuration.should_receive(:raw_settings).once.and_return(settings)
      Wyatt::Configuration.load!(file_path)
    end

    it 'should initialize core_settings with the value of the core key' do
      Wyatt::Configuration.stub(:raw_settings) { settings }
      Wyatt::Configuration.load!(file_path)

      Wyatt::Configuration.core_settings.should eq(core_settings)
    end

  end

  describe '.raw_settings' do

    let(:raw_yaml_string) { "this is totally valid yaml" }

    before do
      Wyatt::Configuration.stub(:file_path) { file_path }
    end

    it 'should call IO.read with the file path' do
      YAML.stub!(:load)

      IO.should_receive(:read).once.with(file_path)
      Wyatt::Configuration.raw_settings
    end

    it 'should call YAML::load with the results of IO.read' do
      IO.stub!(:read) { raw_yaml_string }

      YAML.should_receive(:load).once.with(raw_yaml_string)
      Wyatt::Configuration.raw_settings
    end

  end

end

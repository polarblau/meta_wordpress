require 'rubygems'
require 'bundler'
require 'tmpdir'
require File.dirname(__FILE__) + '/support/file_matchers'

Bundler.setup

require 'rspec'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'meta_wordpress'

FIXTURES_DIR = Pathname.new(__FILE__).dirname + 'fixtures'

RSpec.configure do |config|
  config.order = 'random'

  # https://github.com/docwhat/homedir/blob/homedir3/spec/spec_helper.rb#L14
  config.before(:each) do
    $0                  = "wp"
    ARGV.clear
    @directory          = Dir.mktmpdir('tmp-spec-')
    @orig_directory     = Dir.pwd
    Dir.chdir(@directory)
    @fixtures_path = File.join(Pathname.new(__FILE__).dirname, 'fixtures')
    FileUtils.cp_r(Dir.glob(fixtures_path("*")), @directory)
  end

  config.after(:each) do
    Dir.chdir(@orig_directory)
    FileUtils.rmtree(@directory)
  end

  def project_path(path = "")
    File.join(@directory, path)
  end

  def fixtures_path(path = "")
    File.join(@fixtures_path, path)
  end

  def capture(stream = :stdout)
    begin
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end
    result
  end

end


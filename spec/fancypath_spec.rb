require File.dirname(__FILE__) + '/spec_helper'

describe Fancypath do

before do
  TMP_DIR.rmtree if TMP_DIR.exist?
  TMP_DIR.mkpath
  @file = TMP_DIR.to_path/'testfile'
  @dir = TMP_DIR.to_path/'testdir'
end
after  { TMP_DIR.rmtree }

describe '#join', 'aliased to #/' do

  it('returns a Fancypath') { (@dir/'somefile').class.should == Fancypath }
  it('joins paths') { (@dir/'somefile').to_s.should =~ /\/somefile$/ }

end

describe '#parent' do

  it('returns parent') { @file.parent.should == TMP_DIR.to_path }
  it('returns Fancypath') { @file.parent.should be_instance_of(Fancypath) }

end

describe '#touch', 'file does not exist' do

  it('returns self') { @file.touch.should == @file }
  it('returns a Fancypath') { @file.touch.should be_instance_of(Fancypath) }
  it('creates file') { @file.touch.should be_file }

end

describe '#create', 'dir does not exist' do

  it('returns self') { @dir.create.should == @dir }
  it('returns a Fancypath') { @dir.create.should be_instance_of(Fancypath) }
  it('creates directory') { @dir.create.should be_directory }

end

describe '#remove' do

  it('returns self') { @file.remove.should == @file }
  it('returns a Fancypath') { @file.remove.should be_instance_of(Fancypath) }
  it('removes file') { @file.touch.remove.should_not exist }
  it('removes directory') { @dir.create.remove.should_not exist }

end

describe '#write' do

  it('returns self') { @file.write('').should == @file }
  it('returns a Fancypath') { @file.write('').should be_instance_of(Fancypath) }
  it('writes contents to file') { @file.write('test').read.should == 'test' }

end

describe '#copy' do

  before { @file.touch }
  it('returns a Fancypath') { @file.copy(TMP_DIR/'foo').should be_instance_of(Fancypath) }
  it('creates a new file') { @file.copy(TMP_DIR/'foo').should exist }
  it('keeps the original') { @file.copy(TMP_DIR/'foo'); @file.should exist }
  it('copies the contents') { @file.copy(TMP_DIR/'foo').read.should == @file.read }

end

describe '#set_extension' do

  example "file without extension" do
    Fancypath('/tmp/foo').set_extension('rb').should == Fancypath('/tmp/foo.rb')
  end

  example "single extension" do
    Fancypath('/tmp/foo.py').set_extension('rb').should == Fancypath('/tmp/foo.rb')
  end

  example "multi extension" do
    Fancypath('/tmp/foo.py.z').set_extension('rb').should == Fancypath('/tmp/foo.py.rb')
  end

end

describe '#move' do

  example "destination has the file contents, source does not exist" do
    @file.write('foo')
    dest = TMP_DIR/'newfile'
    @file.move( dest )
    @file.should_not exist
    dest.read.should == 'foo'
  end

end

describe '#has_extension?' do

  example do
    Fancypath('/tmp/foo.bar').has_extension?('bar').should be_true
  end

  example do
    Fancypath('/tmp/foo.bar').has_extension?('foo').should be_false
  end

end

describe '#select' do

  example 'with symbol' do
    @dir.create_dir
    %W(a.jpg b.jpg c.gif).each { |f| (@dir/f).touch }

    @dir.select(:jpg).should == [@dir/'a.jpg', @dir/'b.jpg']
  end

  example 'with glob' do
    @dir.create_dir
    %W(a.jpg b.jpg c.gif).each { |f| (@dir/f).touch }

    @dir.select("*.jpg").should == [@dir/'a.jpg', @dir/'b.jpg']
  end

  # todo: with regex
  # todo: with block

end

end #/Fancypath

describe "String#to_path" do

  it('returns a Fancypath') { 'test'.to_path.should be_instance_of(Fancypath) }

end

describe "Pathname#to_path" do

  it('returns a Fancypath') { Fancypath.new('/').to_path.should be_instance_of(Fancypath) }

end
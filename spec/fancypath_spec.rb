require File.dirname(__FILE__) + '/spec_helper'

describe Fancypath do

before do
  TMP_DIR.rmtree if TMP_DIR.exist?
  TMP_DIR.mkpath
  @file = TMP_DIR.to_path/'testfile'
  @dir = TMP_DIR.to_path/'testdir'
end
after  { TMP_DIR.rmtree }

describe '#/' do
  
  it('returns Fancypath') { (@dir/'somefile').class.should == Fancypath }  
  it('joins paths') { (@dir/'somefile').to_s.should =~ /\/somefile$/ }
  
end

describe '#touch', 'file does not exist' do
  
  it('returns self') { @file.touch.should == @file }  
  it('creates file') { @file.touch.should be_file }
  
end

describe '#create', 'dir does not exist' do
  
  it('returns self') { @dir.create.should == @dir }  
  it('creates directory') { @dir.create.should be_directory }
  
end

describe '#remove' do
  
  it('returns self') { @file.remove.should == @file }
  it('removes file') { @file.touch.remove.should_not exist }  
  it('removes directory') { @dir.create.remove.should_not exist }
  
end

describe '#write' do
  
  it('returns self') { @file.write('').should == @file }
  it('writes contents to file') { @file.write('test').read.should == 'test' }
  
end


end #/Fancypath
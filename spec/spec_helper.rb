$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'fancypath'

TMP_DIR = Pathname.new(__FILE__).dirname.join('tmp', 'fancypath')

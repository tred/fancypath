require 'pathname'

class Pathname
  def to_path
    Fancypath.new(self)
  end

  alias_method :to_fancypath, :to_path

end

class String
  def to_path
    Fancypath.new(self)
  end

  alias_method :to_fancypath, :to_path

end

class Fancypath < Pathname
  # methods are chainable and do what you think they do
  
  alias_method :exists?, :exist?
  alias_method :rename_to, :rename

  def /(path)
    self.join(path).to_path
  end

  # make file
  def touch
    FileUtils.touch self.to_s
    self.to_path
  end
  
  # make dir
  def create
    mkpath unless exist?
    self.to_path
  end
  
  # file or dir
  def remove
    directory? ? rmtree : delete if exist?
    self.to_path
  end
  
  def write(contents, mode='wb')
    dirname.create
    open(mode) { |f| f.write contents }
    self.to_path
  end
  
  def append(contents)
    write(contents,'a+')
  end
  
  def visible_children
    children.reject { |c| c.basename.to_s =~ /^\./ }
  end
  
  def inspect
    super.sub('Pathname','Fancypath')
  end
  
  def to_path
    self
  end
  
end

def Fancypath(path); Fancypath.new(path) end

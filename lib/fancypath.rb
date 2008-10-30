require 'pathname'

class Pathname
  def to_path
    Fancypath.new(self)
  end
end

class String
  def to_path
    Fancypath.new(self)
  end
end

class Fancypath < Pathname
  # methods are chainable and do what you think they do
  
  alias_method :exists?, :exist?

  def /(path)
    self.join(path).to_path
  end

  # make file
  def touch
    FileUtils.touch self.to_s
    self
  end
  
  # make dir
  def create
    mkpath unless exist?
    self
  end
  
  # file or dir
  def remove
    directory? ? rmtree : delete if exist?
    self
  end
  
  def write(contents)
    dirname.create
    open('wb') { |f| f.write contents }
    self
  end
  
  def visible_children
    children.reject { |c| c.basename.to_s =~ /^\./ }
  end
  
end

def Fancypath(path); Fancypath.new(path) end

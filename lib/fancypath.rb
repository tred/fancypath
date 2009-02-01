require 'pathname'

class Pathname
  
  def to_fancypath
    Fancypath.new(self)
  end

  alias_method :to_path, :to_fancypath

end

class String
  
  def to_fancypath
    Fancypath.new(self)
  end

  alias_method :to_path, :to_fancypath

end

class Fancypath < Pathname
  # methods are chainable and do what you think they do
  
  alias_method :exists?, :exist?
  alias_method :rename_to, :rename
  
  def join(path)
    super(path).to_path
  end
  
  alias_method :/, :join

  # make file
  def touch
    FileUtils.touch self.to_s
    self.to_path
  end
  
  def create_dir
    mkpath unless exist?
    self.to_path
  end
  
  alias_method :create, :create_dir
  
  def copy(dest)
    FileUtils.cp(self, dest)
    self
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
    self
  end
  
  def set_extension(ext)
    base = self.to_s[/^ (.+?) (\. ([^\.]+))? $/x, 1]
    self.class.new(base + '.' + ext)
  end
  
  def parent
    super.to_path
  end
  
  alias_method :all_children, :children
  
  def children
    super.reject { |c| c.basename.to_s =~ /^\./ }
  end
  
  def inspect
    super.sub('Pathname','Fancypath')
  end
  
  def to_path
    self
  end
  
end

def Fancypath(path); Fancypath.new(path) end

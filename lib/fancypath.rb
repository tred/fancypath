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

  alias_method :dir, :dirname
  alias_method :directory, :dirname

  alias_method :expand, :expand_path
  alias_method :abs, :expand_path
  alias_method :absolute, :expand_path

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

  alias_method :cp, :copy

  # file or dir
  def remove
    directory? ? rmtree : delete if exist?
    self.to_path
  end

  alias_method :rm, :remove
  def write(contents, mode='wb')
    dirname.create
    open(mode) { |f| f.write contents }
    self.to_path
  end

  def append(contents)
    write(contents,'a+')
    self
  end

  def move(dest)
    self.rename(dest)
    dest.to_path
  end

  def tail(bytes)
    return self.read if self.size < bytes
    open('r') do |f|
      f.seek(-bytes, IO::SEEK_END)
      f.read
    end
  end

  alias_method :mv, :move

  def set_extension(ext)
    "#{without_extension}.#{ext}".to_path
  end

  def without_extension
    to_s[/^ (.+?) (\. ([^\.]+))? $/x, 1].to_path
  end

  def has_extension?(ext)
    !!(self.to_s =~ /\.#{ext}$/)
  end

  def parent
    super.to_path
  end

  alias_method :all_children, :children

  def children
    super.reject { |c| c.basename.to_s =~ /^\./ }
  end

  # only takes sym atm
  def select(arg)
    case arg
    when Symbol ; Dir["#{self}/*.#{arg}"].map { |p| self.class.new(p) }
    else ; Dir["#{self}/#{arg}"].map { |p| self.class.new(p) }
    end
  end

  def inspect
    super.sub('Pathname','Fancypath')
  end

  def to_path
    self
  end

end

def Fancypath(path); Fancypath.new(path) end

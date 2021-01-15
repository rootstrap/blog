# **How To Make Your First Ruby Gem (a step-by-step guide)**

It could be argued, that most developers who have worked with ruby on rails, might be interested in developing a specific gem to solve problems for their fellow developers. 

However, it's not uncommon for developers to not know where to begin, or where a gem is created in the first place. It's also not uncommon for a developer to feel like this would be a difficult and complicated task. For that reason, the aim of this article is to explain how to develop your first gem, and also take a look at the different components involved.  

Here at Rootstrap, we are very interested in being reconized in the open source world. For that reason, we have been working in this topic for some time, making libraries for diferents languages and frameworks and making them visible with blogs and posts in social media. In particular, we made [rsgem](https://github.com/rootstrap/rsgem), a gem which generates a base project to make a gem, in which one this article is based on.


## Starting The Gem

The first step here is to install the rsgem by running `$ gem install rsgem`. Once the gem is installed, we have to run `$ rsgem new [name]`, with the name that we want for our gem included. In this blog, we will pay close attention to running the command `$ rsgem new blog_gem`, as this will generate a project with the following structure:

<img src="images/rsgem_structure.png"
     alt="Blog Gem"
     width="500" height="250"
     align="middle"/>

It's important to mention that the gem rsgem is based on the command 'bundle gem', as it is the command that generates the directories, and the files that are on display. Therefore, we will look at the different components that are generated for the gem that we want to create.

## Bin Folder

<img src="images/bin_folder.png"
     alt="Bin folder"
     width="500" height="250"
     align="middle"/>

In the Bin folder, we will find the console and setup files. The important thing here is to highlight the utility of the console file, where we can see the next code:


```ruby
#!/usr/bin/env ruby

require 'bundler/setup'
require 'blog_gem'

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# (If you use this, don't forget to add pry to your Gemfile!)
# require "pry"
# Pry.start

require 'irb'
IRB.start(__FILE__)
```

If we have to test from the terminal with our gem, we just need the command bundle console 'require_name', to access the interactive ruby shell with each of our methods, and also the dependencies of the gem. In our gem example, we just need to include a bundle console blog_gem.

## Lib Folder

<img src="images/lib_folder.png"
     alt="Lib folder"
     width="500" height="250"
     align="middle"/>

The Lib folder is where the magic happens, as it is where we put the classes, codes, and methods, that will be on offer to the developers when using our gem. If you look closely, you will see a folder with the name of our gem, and if you look inside the folder, you will find a file with the name version. This version file is used to indicate the current version of our gem, and will also be used to complete the version attribute of our gemspec file, which we will see later.

As well as this, we have the file name_gem.rb (in our example 'blog_gem.rb'), which is the main file of the gem. This file contains specific code similar to the following:

```ruby
require 'blog_gem/version'

module BlogGem
  class Error < StandardError; end
  # Your code goes here...
end

```

As we can see here, it is a class wherein principle, you could put the code directly in. That decision is up to the developer, but generally, there won't be code added to this file. Instead of this, 'requires' will be added to the files, which contain the classes that offer the methods of our gem. We can also see that this class covers generic error handling, which follows the ruby guidelines.

## Spec Folder

<img src="images/spec_folder.png"
     alt="Spec folder"
     width="500" height="250"
     align="middle"/>

In the world of software development, it's understood that good software always has to have unit tests that support the implemented code. For this very reason, here at Rootstrap, we use RSpec. Our test files must be put in the spec folder, as this will allow us to implement the unit tests of our gem, which we can execute from the console with the RSpec command.

## Gemspec File

```ruby
require_relative 'lib/blog_gem/version'

Gem::Specification.new do |spec|
  spec.name          = 'blog_gem'
  spec.version       = BlogGem::VERSION
  spec.authors       = ['TimoPeraza']
  spec.email         = ['timothy@rootstrap.com']

  spec.summary       = ''
  spec.description   = ''
  spec.homepage      = ''
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir['LICENSE.txt', 'README.md', 'lib/**/*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
end
```

In this file, we will put all the information for our gem, i.e. who made it, contact email, description, and the version. This file will also contain the files that allow the gem to do a release and the external dependencies with which the gem needs.

By default, rsgem adds the dev dependencies: rake, reek, rspec, rubocop, and simplecov. This is because in Rootstrap we focus a lot on the quality of the code, it seems to us something very important when developing therefore, we add these dependencies to control that our gem has good quality.

## Readme File

Finally, in the readme file we will add all the information about our gem, how it works, how to install it, the methods it offers and everything that is useful so another developer can use it.

Now we have a general idea of the components that the project has, just get down to work and make your first gem! For more information about how to make a gem I strongly recommend looking at the page of [rubygems](https://guides.rubygems.org/make-your-own-gem/)

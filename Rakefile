require 'tmpdir'
require 'colorize'

def sh(cmd)
  begin
    PTY.spawn(cmd) do |stdout, stdin, pid|
      begin
        stdout.each { |line| print line }
      rescue Errno::EIO
        # do nothing
      end
    end
  rescue PTY::ChildExited
    puts "The child process [ #{cmd} ] exited.".red
  ensure
    raise "Non-zero exit status from [ #{cmd} ]." unless $?.to_i.zero?
  end
end

def working_tree_is_clean?
  system(%{git diff-index --quiet HEAD && test -z "$(git ls-files --other --exclude-standard)"})
end

def current_branch
  %x{git branch | grep '*' | sed 's/*\s//'}.chomp
end

def head_hash
  %x{git rev-list HEAD | head -n1}.chomp
end

def git_remote
  %x{git remote}.chomp
end

desc "generate static site and publish to github pages. Usage: rake publish [push=true|false] [publish_branch=BRANCH]\n\n push - boolean value to enable/disable pushing the static site to github pages. Defaults to 'true' if not given. When assigning a value to push, anything other than 'true' evaluates to false.\n publish_branch - Remote branch where the static site is pushed. Defaults to 'master' if not given."
task :publish do
  if ENV['push']
    push = ENV['push'].to_s == 'true' ? true : false
  else
    push = true
  end

  if ENV['verbose']
    verbosity = ENV['verbose'].to_s == 'true' ? '--verbose ' : ''
  else
    verbosity = ''
  end

  publish_branch = ENV['publish_branch'] || 'master'

  sh("jekyll clean")
  puts
  sh("jekyll build")
  puts

  Dir.mktmpdir do |tmp|
    unless working_tree_is_clean?
      puts 'working tree is dirty - exiting...'.red
      exit 1
    end

    start_branch = current_branch
    start_hash = head_hash

    sh("mv #{verbosity}_site/* #{tmp}")
    puts
    sh("git checkout -B #{publish_branch}")
    puts
    sh("rm #{verbosity}--recursive --force .sass-cache .gitignore .ruby-version .ruby-gemset *")
    puts
    sh("mv #{verbosity}#{tmp}/* .")
    puts
    sh("git add --all")
    puts
    sh("git commit --message 'site-generation based on #{start_hash}'")
    puts
    sh("git push #{git_remote} #{publish_branch} --force") if push
    puts
    sh("git checkout #{start_branch}")
    puts
    sh("git branch -D #{publish_branch}") if push
  end
end

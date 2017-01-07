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

def publish_branch
  ENV['publish_branch'] || 'master'
end

def head_hash
  %x{git rev-list HEAD | head -n1}.chomp
end

def git_remote
  %x{git remote}.chomp
end

task :publish do
  if ENV['push']
    push = ENV['push'].to_s == 'true' ? true : false
  else
    push = true
  end

  sh("jekyll clean")
  sh("jekyll build")

  Dir.mktmpdir do |tmp|
    unless working_tree_is_clean?
      puts 'working tree is dirty - exiting...'.red
      exit 1
    end

    start_branch = current_branch
    start_hash = head_hash

    sh("mv --verbose _site/* #{tmp}")
    sh("git checkout -B #{publish_branch}")
    sh("rm --verbose --recursive --force *")
    sh("mv --verbose #{tmp}/* .")
    sh("git add --all")
    sh("git commit --message 'site-generation based on #{start_hash}'")
    sh("git push #{git_remote} master --force") if push
    sh("git checkout #{start_branch}")
  end
end

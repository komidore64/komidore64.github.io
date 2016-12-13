require 'tmpdir'
require 'colorize'

task :publish do
  sh("jekyll clean")
  sh("jekyll build")

  Dir.mktmpdir do |tmp|
    unless working_tree_is_clean?
      puts "working tree is dirty - exiting...".red
      exit 1
    end

    branch = `git branch | grep '*' | sed 's/*\s//'`.chomp
    hash = `git rev-list HEAD | head -n1`.chomp
    remote = `git remote`.chomp

    sh("mv --verbose _site/* #{tmp}")
    sh("git checkout -B master")
    sh("rm --verbose --recursive --force *")
    sh("mv --verbose #{tmp}/* .")
    sh("git add --all")
    sh("git commit --message 'site-generation based on #{hash}'")
    sh("git push #{remote} master --force")
    sh("git checkout #{branch}")
  end
end

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

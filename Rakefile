#!/usr/bin/env rake

task :default do
  ["rspec", "cucumber"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system(cmd)
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end

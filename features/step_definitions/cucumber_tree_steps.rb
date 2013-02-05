module CucumberTreeHelper
  def rails_new(options={})
    options[:name] ||= 'test_app'
    run_simple "rails new #{options[:name]} --skip-bundle --skip-test-unit #{options[:args]}"
    assert_passing_with('README')
    cd options[:name]
  end

  def install_cucumber_tree(*options)
    gem "cucumber_tree", group: :test, path: "#{File.expand_path('.')}", require: false
    run_simple 'bundle exec rails generate cucumber:install'
    replace_content('config/cucumber.yml', /std_opts = "/, 'std_opts = "--require features ')
    append_to_file('features/support/env.rb', "require 'cucumber_tree'")
  end

  def replace_content(file, from_content, to_content)
    content = with_file_content(file) { |content| content }
    content = content.gsub(from_content, to_content)
    overwrite_file(file, content)
  end

  def gem(name, options)
    line = %{gem "#{name}", #{options.inspect}\n}
    append_to_file('Gemfile', line)
  end
end
World(CucumberTreeHelper)

Given /^I have created a new rails app$/ do
  rails_new
  install_cucumber_tree
end

Given /^I have created a new rails app with postgresql$/ do
  `createuser --superuser test_app`
  rails_new(args: '--database=postgresql')
  install_cucumber_tree
end

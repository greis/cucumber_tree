# Cucumber Tree

Organize your features in a tree directory and don't waste your cpu time running the same steps over and over.

## Installation

Add this line to your application's Gemfile:

    group :test do
      gem 'cucumber_tree', require: false
    end

And then execute:

    $ bundle

If you already have installed cucumber-rails, go to the next step. Otherwise execute:

    $ rails g cucumber:install

Add the option "--require features" to the std_opts in config/cucumber.yml:

    std_opts = "--require features --format #{ENV['CUCUMBER_FORMAT'] || 'pretty'} --strict --tags ~@wip"

Change the file "features/support/env.rb" to require 'cucumber_tree'. It should be after the 'cucumber/rails' line:

    require 'cucumber/rails'
    require 'cucumber_tree'

This gem depends on database_cleaner and overrides the default strategy to :truncation, so you could remove all the references to DatabaseCleaner inside features/support/env.rb

## Usage

Given an application to manage products and the following scenarios:

1. User signs in
2. User adds a new product
3. User edits a product

Using cucumber_tree your tests should be organized in a tree directory:

```
|-- features
`   |-- sign_in.feature
    `-- sign_in
        |-- add_product.feature
        `-- add_product
            `-- edit_product.feature
```

Each feature contains only the necessary steps:

    features/sign_in.feature
      Feature:
        Scenario:
          Given I am signed in
          Then I should see a welcome message

    features/sign_in/add_product.feature
        Feature:
          Scenario:
            When I click to add a new product
            And I create a new product
            Then I should see a message for product creation

    features/sign_in/add_product/edit_product.feature
        Feature:
          Scenario:
            When I click to edit the product
            And I update the product
            Then I should see a message for product update

When you execute `$ cucumber` the file sign_in.feature is the first to run. When it's done, then a snapshot of the current state (database, cookies, current page) is taken. This snapshot is loaded and the file add_product.feature runs. Another snapshot and finally the file edit_product.feature runs.

If you execute `$ cucumber features/sign_in/add_product/edit_product.feature` then all the parent features will be executed before it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

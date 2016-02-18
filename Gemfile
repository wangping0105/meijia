#source 'https://rubygems.org'
source 'https://ruby.taobao.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use mysql2 as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
#//分页
gem 'kaminari'
# emoji表情
gem 'emojimmy'
# To use debugger 调试
# 我自己的一个gem
gem 'alidayu_sms'
# 时间统计
gem 'rack-mini-profiler'
#
gem 'request_store'

group :development do
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'pry-nav'
  # gem 'debugger'
  gem 'thin'
  gem "quiet_assets"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Use Capistrano for deployment 自动化部署
group :development do
  gem 'capistrano-rails', '~> 1.1.3'
  gem 'capistrano3-unicorn', '~> 0.2.1'
  # gem 'sepastian-capistrano3-unicorn', '~> 0.5.1'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-sidekiq'
end

# Use unicorn as the app server
group :production do
  gem 'unicorn'
  gem "unicorn-worker-killer"
end
# zip-zip

[![Build Status](https://travis-ci.org/orien/zip-zip.svg?branch=master)](https://travis-ci.org/orien/zip-zip)
[![Gem Version](https://img.shields.io/gem/v/zip-zip.svg?maxAge=2592000)](https://rubygems.org/gems/zip-zip)
[![Gem Downloads](https://img.shields.io/gem/dt/zip-zip.svg?maxAge=2592000)](https://rubygems.org/gems/zip-zip)

So you've upgraded a gem dependency that requires RubyZip v1.0.0 or higher.
While all your other dependencies use the interface provided by v0.x.

**zip-zip** provides a simple adapter to let all your dependencies use RubyZip v1.0.0.
It is very simple and light weight, aliasing the old class names to the new.

## Installation

Add this line to your application's Gemfile:

    gem 'zip-zip'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zip-zip

## Contributing

1. Fork it ( https://github.com/orien/zip-zip/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

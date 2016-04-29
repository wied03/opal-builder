# opal-builder

[![Build Status](http://img.shields.io/travis/wied03/opal-builder/master.svg?style=flat)](http://travis-ci.org/wied03/opal-builder)
[![Quality](http://img.shields.io/codeclimate/github/wied03/opal-builder.svg?style=flat-square)](https://codeclimate.com/github/wied03/opal-builder)
[![Version](http://img.shields.io/gem/v/opal-builder.svg?style=flat-square)](https://rubygems.org/gems/opal-builder)


An attempt at making the builder XML gem work with Opal

## Usage

Add `opal-builder` to your Gemfile:

```ruby
gem 'opal-builder'
```

### Use in your application

```ruby
require 'builder'
```

Limitations:
* declare! can't be used to create DOCTYPES, etc. right now because Opal treats symbols as strings
* Character set encoding does not work

## Contributing

Install required gems at required versions:

    $ bundle install

A simple rake task should run the example specs in `spec/`:

    $ bundle exec rake

### Run in the browser

Run attached rack app to handle building:

    $ bundle exec rackup

Visit the page in any browser and view the console:

    $ open http://localhost:9292

## License

Authors: Brady Wied

Copyright (c) 2015, BSW Technology Consulting LLC
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[![Build Status](https://travis-ci.org/masami256/minitest-names.svg?branch=master)](https://travis-ci.org/masami256/minitest-names)

# minitest-names

It supports to run multiple testcases by it testcase names.
The minitest supports regular expression to run some testcases with -n/--name option. However, sometime it's difficult to make regular expression for test.
So, it would be nice to have a feature passing testcase names to run tests.

minitest-names doesn't support regular expression.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-names'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-names

## Usage

To pass testcase name which separated by comma.


Using short option.
```
$ rake TESTOPTS="-N=\"test_say_hello, test_say_kiaora\""
```

Using long option.
```
rake TESTOPTS="--names=\"test_say_hello, test_say_kiaora\""
```

In the TESTOPTS option, you need to escape double quotation.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/minitest-names/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

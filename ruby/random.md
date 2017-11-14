```ruby
    # todo: refactor this into an rspec test
    matches.each do |match|
      puts
      match.gsub(/(..)/) do |result|
        print result + ' '
      end
    end
```

4 bits = 1 hex (F)
8 bits = 1 byte = 2 hex (FF)

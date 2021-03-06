# SP Test

## Setup
- Clone repo to local
- cd into ```sptest```
- grab gem (rspec) ```bundle install```
- run test suite ```bundle exec rspec```

## Parsing
- Run ```ruby bin/logger path/to/file``` to parse the input
- I have uploaded the sample file for ease of use, so you could just run
    ```ruby bin/logger webserver.log``` :)
- Specify if you require total (t) visits to each address, or a count of unique visits (u)

## Notes 
- I have tried to keep the code as clean as possible, however I am still pretty raw in terms of design and implementation (very open to any feedback!)
- Tests are located in the spec directory (RSpec)
Thanks, Edd

-Flog scores for a bit of fun:

    4.7: flog/method average
    
    19.2: Logger::run                      lib/logger.rb:6-16
    13.0: Parser#report_unique             lib/parser.rb:46-53
    13.0: Parser#report_total              lib/parser.rb:28-35
    10.0: Log#generate                     lib/log.rb:24-30
     7.7: Log#add_new_logline              lib/log.rb:51-54
     7.6: Parser#line_unique               lib/parser.rb:60-61
     7.6: Parser#line_total                lib/parser.rb:42-43
     6.5: Log#log_finder                   lib/log.rb:47-48
    
     .....

# SP Test

- Clone repo to local
- cd into ```sptest```
- Run ```ruby bin/logger path/to/file``` to parse the input
-- I have uploaded the sample file for ease of use, so you could just run
    ```ruby bin/logger webserver.log``` :)
- Tests are located in the spec directory (RSpec)
- I have tried to keep the code as clean as possible, however i am still pretty raw in terms of design and implementation (very open to any feedback!)

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

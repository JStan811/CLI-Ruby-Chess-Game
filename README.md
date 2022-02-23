# CLI Ruby Chess Game

Hi! This is a Command line chess program written in Ruby as part of the [Odin](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/ruby-final-project) curriculum.

Features
--------

- 2 player Chess game with support for all standard Chess rules
- Working game board display that updates as game state changes
- Program automatically validates and enforces legal moves and check/checkmate scenarios
- Players can save and load games

How to play
------------

Prerequisites
- ruby ([how to install](https://www.ruby-lang.org/en/documentation/installation/))

You can run online on [Repl.it](https://replit.com/@JakeStandley/chess?v=1) but to use a faster and more stable version:

1. clone this repo ([instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository))
3. navigate to your new local repo
3. type and enter `ruby lib/main.rb`

Instructions
------------

1. Player 1 controls the white pieces starting on rows 1 and 2. Player 2 controls the black pieces starting on rows 7 and 8.
2. Game move notation is 'starting cell''ending cell'. For example, to move a piece from a2 to a4, enter 'a2a4'.
3. From here the game follows standard chess rules which are described in much better detail than I could ever come up with on the [Chess Wikipedia page](https://en.wikipedia.org/wiki/Chess).

Design Specs
------------

- This program is writtenly completely from scratch using vanilla Ruby
- Object organization uses object oriented classical inheritance  (eg the Knight class inherits from Piece) with every object coming from a hand-rolled class
- Modules are also used to share code (eg the LineMovement module is used be the Queen, Knight, and Rook classes)
- YAML serialization is used to manage save and load functionality
- I tried to keep my code clean by refactoring throughout the development process, aiming to keep my code DRY, keep classes and method bodies short and with single responsibilities, and using meaningful variable, method, and class names

Support/Feedback
-------

If you are having issues or have any feedback, please let me know!
I can be reached at jake-standley@outlook.com

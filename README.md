# CLI Ruby Chess Game

Hi! This is a Command line chess program written in Ruby. 

Run on [Repl.it](https://replit.com/@JakeStandley/chess?v=1) (But run a faster and more stable version by cloning the repo.)

Features
--------

- Complete Chess game with support for 
- Make things faster

Installation
------------

Install $project by running:

    install project

Project Requirements
2-Player Game with Legal Moves: I wanted to create a similar UI as chess.com to visually display the opponent's previous piece, the active piece, and the legal moves/captures. Therefore, I needed to divide each turn into two different parts.

Save and Load Games: Players can save (or quit) a game at the beginning of every turn. Before a game starts, players have the choice to play a new game or load a saved game.

Tests: I wrote unit tests for incoming command methods, incoming query methods, and outgoing command methods. Most of the time, I wrote tests and the method in tandem. Occasionally, I used TDD when I wanted the test to guide the results. For example, I used TDD as I developed the methods that determined each piece's moves and captures.

Simple Computer Player (Optional): Since the white player always goes first and has a slightly higher advantage, I decided to have the computer player always be black to keep the game set-up simple. The computer player selects a piece with legal moves and/or captures.

Support/Feedback
-------

If you are having issues or have any feedback, please let me know.
I can be reached at jake-standley@outlook.com

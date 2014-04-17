<h1>WordsPlease</h1>
A Perl script to find all words in a dictionary containing specified letters.

<h2>Usage</h2>
Create an instance of WordsPlease that points to your dictionary directory and specifies an optional maximum word count to search for.
```perl
use WordsPlease;
my $wordsPlease = new WordsPlease("dictionaries", 1000);
```

Get an array of matched words, either exclusively or inexclusively (1 and 0 respectively), and matched with a maximum quantity of letters in the input (1 and 0 respectively).
```perl
my @matchedWords = $wordsPlease->wordsWith("abcde", 1, 1);
```
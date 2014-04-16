<h1>WordsPlease</h1>
A Perl script to find all words in a dictionary containing specified letters.

<h2>Usage</h2>
Create an instance of WordsPlease that points to your dictionary directory.
```perl
use WordsPlease;
my $wordsPlease = new WordsPlease("dictionaries");
```

Get an array of matched words, either exclusively or inexclusively (1 and 0 respectively).
```perl
my @matchedWords = $wordsPlease->wordsWith("abcde", 1);
```
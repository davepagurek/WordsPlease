<h1>WordsPlease</h1>
A Perl script to find all words in a dictionary containing specified letters.
Live demo available at <a href="http://pahgawks.com/wordsplease">http://pahgawks.com/wordsplease</a>

<h2>Usage</h2>
Create an instance of WordsPlease that points to your dictionary directory and specifies an optional maximum word count to search for.
```perl
use WordsPlease;
my $wordsPlease = new WordsPlease("dictionaries", 1000);
```

Word list text files can be downloaded online from your source of choice. The live demo uses the <a href="http://www-01.sil.org/linguistics/wordlists/english/">SIL International list.</a>

Get an array of matched words.
Parameters:
<ol>
	<li>Letters</li>
	<li>Exclusivity: If yes, no letters not listed can be in the word</li>
	<li>Match Quantity: If yes, only as many of each letter as appear in the letters string can be in the word</li>
</ol>
```perl
my @matchedWords = $wordsPlease->wordsWith("abcde", 1, 1);
```

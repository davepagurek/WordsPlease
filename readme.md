<h1>WordsPlease</h1>
A Perl script to find all words in a dictionary containing specified letters.
Live demo available at <a href="http://pahgawks.com/wordsplease">http://pahgawks.com/wordsplease</a>

<h2>Input</h2>
WordsPlease works with text files with one word per line.

<h2>Usage</h2>
<h3>1. Create an instance of WordsPlease</h3>
Parameters:
<ol>
	<li>Directory: The directory with your dictionary text files</li>
	<li>Word limit (optional): If a limit is specified, WordsPlease stops after finding that amount of words in whatever order they were found in.</li>
	<li>Time limit (optional): If a limit is specified, WordsPlease stops looking after the specified number of seconds.</li>
</ol>
```perl
use WordsPlease;
my $wordsPlease = new WordsPlease("dictionaries", 1000, 3);
```

Word list text files can be downloaded online from your source of choice. The live demo uses the <a href="http://www-01.sil.org/linguistics/wordlists/english/">SIL International list.</a>

<h3>2. Get an array of matched words</h3>
Parameters:
<ol>
	<li>Letters</li>
	<li>Exclusivity (optional, default is 0): If 1, no letters not listed can be in the word</li>
	<li>Match Quantity (optional, default is 0): If 1, only as many of each letter as appear in the letters string can be in the word</li>
</ol>
```perl
my @matchedWords = $wordsPlease->wordsWith("abcde", 1, 1);
```

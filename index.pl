#!C:/xampp2/perl/bin/perl.exe

use CGI;
use v5.10;
use WordsPlease;

print "Content-Type: text/html; charset=iso-8859-1\n\n";


my $input = new CGI;
my $letters = CGI::escapeHTML($input->param("letters")) || "abcde";
my $dir = CGI::escapeHTML($input->param("dir")) || "words";
my $new = CGI::escapeHTML($input->param("new"));
my $exclusive = CGI::escapeHTML($input->param("exclusive")) || !$new;
my $wordsPlease = new WordsPlease($dir);
my @matchedWords = sort($wordsPlease->wordsWith($letters, $exclusive));

say '<html>';
say '<head>';
say "<meta name='viewport' content='width=device-width, initial-scale=1.0'>";
say "<link href='http://fonts.googleapis.com/css?family=Bitter:400' rel='stylesheet' type='text/css'>";
say "<link rel='stylesheet' type='text/css' href='style.css' />";
say '<title>Words Please</title>';
say '</head>';
say '<body>';
say '<h1>Words Please</h1>';
say "<form action='' method='get'>";
say "<label>Letters in word: </label><input type='text' name='letters' value='$letters' /><br />";
print "<label>Only using these letters: <input type='checkbox' name='exclusive' id='exclusive' value='true'";
if ($exclusive) {
	print " checked ";
}
print "/><label for='exclusive' class='checkbox'></label><br />\n";
say "<input type='hidden' name='new' value='false' />";
say "<input type='submit' value='Search' />";
say '</form>';

say "<h2>Words That Match</h2>";
if (scalar @matchedWords > 0) {
	say "<ul>";
	foreach my $word (@matchedWords) {
		say "<li>$word</li>";
	}
	say "</ul>";
} else {
	say "<p>No matches found.</p>";
}

say '</body>';
say '</html>';
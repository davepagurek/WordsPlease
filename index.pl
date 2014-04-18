#!C:/xampp2/perl/bin/perl.exe

#This is an example usage of the WordsPlease package.

use CGI;
use WordsPlease;

sub say { print @_, "\n" } #Support for Perl < 5.10

print "Content-Type: text/html; charset=iso-8859-1\n\n";


my $input = new CGI;
my $letters = 0;
if (CGI::escapeHTML($input->param("letters"))) {
	$letters = lc(CGI::escapeHTML($input->param("letters")));
}
my $default = "srerettulfekip";
my $limit = 800;
my $dir = "words";
my $exclusive = CGI::escapeHTML($input->param("exclusive"));
my $occurrences = CGI::escapeHTML($input->param("occurrences"));
my $wordsPlease = new WordsPlease($dir, $limit, 3);
my @matchedWords = ();
if ($letters) {
	@matchedWords = sort { length $b <=> length $a } $wordsPlease->wordsWith($letters, $exclusive, $occurrences);
} else {
	@matchedWords = sort { length $b <=> length $a } $wordsPlease->wordsWith($default, 1, 1);
}

say '<html>';
say '<head>';
say "<meta name='viewport' content='width=device-width, initial-scale=1.0'>";
say "<link href='http://fonts.googleapis.com/css?family=Bitter:400' rel='stylesheet' type='text/css'>";
say "<link rel='stylesheet' type='text/css' href='style.css' />";
say '<title>Words, Please</title>';
say '</head>';
say '<body>';
say '<div id="header">';
say '<h1>Words, Please</h1>';
say '<h3>Find all the words that can be made with a set of letters.</h3>';
say "<form action='' method='get'>";
print "<label>Letters in word: </label><input type='text' name='letters' value='";
if ($letters) {
	print $letters;
} else {
	print $default;
}
print "' /><div class='break'></div>\n";
print "<label>Only using these letters: </label><input type='checkbox' name='exclusive' id='exclusive' value='true'";
if ($exclusive || !$letters) {
	print " checked ";
}
print "/><label for='exclusive' class='checkbox'></label><div class='break'></div>\n";
print "<label>Only as many of each letter as specified: </label><input type='checkbox' name='occurrences' id='occurrences' value='true'";
if ($occurrences || !$letters) {
	print " checked ";
}
print "/><label for='occurrences' class='checkbox'></label><div class='break'></div>\n";
say "<input type='submit' value='Search' />";
say '</form>';
say '</div>';

say "<div id='words'>";
say "<h2>Matched Words</h2>";
say "<div id='content'>";
if (scalar @matchedWords > 0) {
	foreach my $word (@matchedWords) {
		say "<div class='word'>$word</div>";
	}
	if (scalar @matchedWords >= $limit) {
		say "<p>To reduce server load, only $limit words are displayed.</p>";
	}
} else {
	say "<div class='word'>No matches found.</div>";
}
say "</div></div>";
say "<div id='footer'>";
say "<p>A project by <a href='http://www.pahgawks.com'>Dave Pagurek</a>, 2014.</p>";
say "<a class='github' href='https://github.com/pahgawk/WordsPlease/'>View source on GitHub</a>";
say "</div>";
say '</body>';
say '</html>';

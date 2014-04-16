#!C:/xampp2/perl/bin/perl.exe

use CGI;
use v5.10;

print "Content-Type: text/html; charset=iso-8859-1\n\n";


my $input = new CGI;
my $letters = CGI::escapeHTML($input->param("letters")) || "abcde";
my $lettersExp = qr/$letters/;
my $dir = CGI::escapeHTML($input->param("dir")) || "words";

say '<html>';
say '<head>';
say '<title>Words Please</title>';
say '</head>';
say '<body>';
say '<h1>Words Please</h1>';
say "<form action='wordsplease.pl' method='get'>";
say "<label>Letters in word: </label><input type='text' name='letters' value='$letters'><br />";;
say "<input type='submit' value='Search'>";
say '</form>';


if ($dir && $letters) {
	say "<h2>Words That Match</h2>";
	say "<ul>";
	foreach my $dictionaryFile (glob("$dir/*")) {
		open my $dictionary, "<", $dictionaryFile or die "Can't read open '$dictionaryFile': $OS_ERROR";
		while (<$dictionary>) {
			chomp;
			if (m/^([${lettersExp}]+)$/) {
				say "<li>$_</li>";
			}
		}
		close $dictionary or die "can't read close '$dictonary': $OS_ERROR";
	}
	say "</ul>";
}

say '</body>';
say '</html>';
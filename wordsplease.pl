#!C:/xampp2/perl/bin/perl.exe

use CGI;
use v5.10;

print "Content-Type: text/html; charset=iso-8859-1\n\n";


my $input = new CGI;
my $letters = "^[" . CGI::escapeHTML($input->param("letters")) . "]+\$";
my $letersExp = qr/$letters/;
my $dir = CGI::escapeHTML($input->param("dir"));


foreach my $dictionaryFile (glob("$dir/*")) {
	open my $dictionary, "<", $dictionaryFile or die "Can't read open '$dictionaryFile': $OS_ERROR";
	while (<$dictionary>) {
		chomp;
		if (/$lettersExp/i) {
			print $_;
			print "<br>\n";
		}
	}
	close $dictionary or die "can't read close '$dictonary': $OS_ERROR";
}
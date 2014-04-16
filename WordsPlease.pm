#!C:/xampp2/perl/bin/perl.exe

package WordsPlease;

use v5.10;

sub new {
	my $class = shift;
	my $self = {
		dir => shift,
	};
	bless $self, $class;
	return $self;
}

sub wordsWith {
	my ($self, $letters, $exclusive) = @_;
	my @words = ();
	if ($self->{dir} && $letters) {
		my $lettersExp = qr/$letters/;
		foreach my $dictionaryFile (glob("$self->{dir}/*")) {
			open my $dictionary, "<", $dictionaryFile or die "Can't read open '$dictionaryFile': $OS_ERROR";
			while (<$dictionary>) {
				chomp;
				if ($exclusive) {
					if (m/^([${lettersExp}]+)$/) {
						push(@words, $_);
					}
				} else {
					if (m/([${lettersExp}]+)/) {
						push(@words, $_);
					}
				}
			}
			close $dictionary or die "can't read close '$dictonary': $OS_ERROR";
		}
	}
	return @words;
}

1;
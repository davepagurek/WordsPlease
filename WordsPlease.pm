#!C:/xampp2/perl/bin/perl.exe

package WordsPlease;

use v5.10;

sub new {
	my $class = shift;
	my $self = {
		dir => shift,
		limit => shift,
	};
	bless $self, $class;
	return $self;
}

sub wordsWith {
	my ($self, $letters, $exclusive, $occurrences) = @_;
	my @words = ();
	if ($self->{dir} && $letters) {
		my $lettersExp = qr/$letters/;
		foreach my $dictionaryFile (glob("$self->{dir}/*")) {
			open my $dictionary, "<", $dictionaryFile or die "Can't read open '$dictionaryFile': $OS_ERROR";
			while (<$dictionary>) {
				if ($self->{limit} && scalar @words >= $self->{limit}) {
					last;
				}
				chomp;
				my $word = $_;
				if ($exclusive) {
					if ($word =~ /^([${lettersExp}]+)$/) {
						if ($occurrences) {
							my @lettersLeft = split("", $letters);
							my $good = 1;
							for (my $key = 0; $key < length($word); $key++) {
								my $found = 0;
								for (my $l = 0; $l < scalar @lettersLeft; $l++) {
							  		if ($lettersLeft[$l] eq substr($word, $key, 1)) {
							  			splice(@lettersLeft, $l, 1);
							  			$found = 1;
							  			last;
							  		}
								}
								if (!$found) {
									$good = 0;
									last;
								}
							}
							if ($good == 1) {
								push(@words, $word);
							}
						} else {
							push(@words, $word);
						}
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
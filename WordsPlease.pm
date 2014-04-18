package WordsPlease;

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

		#Pattern where only the letters given can be used
		my $lettersExpExcl = "\\b([$letters]+)\\b";

		#Pattern where the letters given don't need to be used exclusively
		my $lettersExp = "([$letters]+)";

		#Look through all files in the dictionary directory
		foreach my $dictionaryFile (glob("$self->{dir}/*")) {
			open my $dictionary, "<", $dictionaryFile or die "Can't read open '$dictionaryFile': $OS_ERROR";
			while (<$dictionary>) {

				#If the word limit exists and has been passed, end the loop
				if ($self->{limit} && scalar @words >= $self->{limit}) {
					last;
				}
				$word = $_;

				#remove whitespace
				$word =~ s/^\s+|\s+$//g;

				#Ignore words that need apostrophes
				if ($word =~ /'/) {
					next;
				}

				#Use the exlusive pattern if given letters are used exclusively
				if ($exclusive) {
					if ($word =~ /$lettersExpExcl/) {

						#If letters can only be used as many times as they appear
						if ($occurrences) {

							my @lettersLeft = split("", $letters);
							$good = 1;

							#See if each letter in the word is in the array of possible letters per word
							for ($key = 0; $key < length($word); $key++) {
								$found = 0;
								for ($l = 0; $l < scalar @lettersLeft; $l++) {

									#If it is, take it out of the array and go to the next letter
							  		if ($lettersLeft[$l] eq substr($word, $key, 1)) {
							  			splice(@lettersLeft, $l, 1);
							  			$found = 1;
							  			last;
							  		}
								}

								#If the letter isn't in the array of possible letters, ignore the word
								if ($found==0) {
									$good = 0;
									last;
								}
							}

							#If the word fits, add it
							if ($good == 1) {
								push(@words, $word);
							}

						#If it's not exclusive, since the pattern already matched, add the word
						} else {
							push(@words, $word);
						}
					}

				#If the letters given don't have to be the only ones in the word
				} elsif ($word =~ /$lettersExp/) {
					push(@words, $word);
				}
			}
			close $dictionary or die "can't read close '$dictonary': $OS_ERROR";
		}
	}
	return @words;
}

1;
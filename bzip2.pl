use warnings;
use strict;

open(FH, '<', './sample2.txt') or die $!;
my $fileString = <FH>;
my @fileText = split //, $fileString;
print "Initial:\n" . $fileString . "\n";

# rle encoding
my @rleEncoding = ();
my $runLength = 1;

for my $i ((1..$#fileText)) {
  if ($fileText[$i-1] eq $fileText[$i]) {
    ++$runLength;
  } else {
    if ($runLength >= 4) {
      $runLength -= 4;
      push @rleEncoding, ($fileText[$i - 1] x 4 . "\\$runLength");
    } else {
      push @rleEncoding, ($fileText[$i - 1] x $runLength);
    }
    $runLength = 1;
  }
}

my $rle = join "", @rleEncoding;
print "After RLE:\n" . $rle . "\n";

# BWT



close(FH);



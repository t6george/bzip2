use warnings;
use strict;

use constant BWT_BLOCK_SIZE => 960 * 1000;

open(FH, '<', './sample2.txt') or die $!;
my $fileString = <FH>;
my @fileText = split //, $fileString;
print "Initial:\n" . $fileString . "\n";

# rle encoding
my @rleEncoding = ();
my $runLength = 1;

for my $i ((1..$#fileText)) {

  # if (($i + 1) % BWT_BLOCK_SIZE == 0) {
  #   push @rleEncoding, "\$";
  # }

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

push @rleEncoding, "\$";

my $rle = join "", @rleEncoding;
print "After RLE:\n" . $rle . "\n";

# BWT

my %suffixMap = ();
my @suffixArray = ();

for my $i ((0..(length $rle) - 1)) {
  $suffixMap{substr $rle, $i, ((length $rle) + 1 - $i)} = $i;
}

for (sort (keys %suffixMap)) {
  push @suffixArray, %suffixMap{$_};
}

my @bwtEncoding = ();

print %suffixMap;

# for my $i ((0..$#suffixArray)) {
#   push @bwtEncoding, (substr $rle, ($suffixArray[$i] + (length $rle) - 1) % (length $rle), 1);
# }

# my $bwt = join "", @bwtEncoding;
# print "After BWT:\n" . $bwt . "\n";



close(FH);



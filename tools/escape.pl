#!/usr/bin/perl -w
# conversion of markup files (i.e. xml, html) into escape characters 

#-----------------------------------------------------------------------------
# Name          : escape.pl (script)
# Author        : Michael Kuegeler
# Function      : 
# Date          : 23.06.2014
# Version       : 1.0
#-----------------------------------------------------------------------------

use strict;
use warnings;

use File::Slurp qw(read_file write_file);

use File::Spec::Functions qw(rel2abs);
use File::Basename;


our $VERSION = '0.1';

# MAIN
#-----------------------------------------------------------------------------
sub main {

my ($infile, $outfile) = @ARGV;
 
if (not defined $infile) {
  die "Infile required\n";
}

if (not defined $outfile) {
  die "Outfile required\n";
} 
	 
print convert_escape_file($infile, $outfile);


# match_characters();

}
# end main

#---------------------------------------------------------------------------
# call main
main();
#---------------------------------------------------------------------------
# sub routines
#---------------------------------------------------------------------------
# reads the file which should be transformed into escape characters and converts escape characters

sub convert_escape_file {
	
	
	# input and out files
	my ($filename, $new) = @_; 
	 
	my $text = read_file($filename) ;
	
	$text =~ s/\</\&lt;/g;
	$text =~ s/\>/\&gt;/g;
	$text =~ s/\"/\&quot;/g;
    
	write_file ($new, $text);
	
    
	return $text;
	
}
#---------------------------------------------------------------------------
#
# show matching characters

sub matching_characters {

# escape character matching template
	
	
	my %escape_template = (
      "<" => ">&lt;",
      ">"  => "&gt;",
      '"'  => "&quot;",
    );
	
for my $ch (keys %escape_template) {
    print "The matching character of '$ch' is $escape_template{$ch}\n";
}
	

	
}


#---------------------------------------------------------------------------
# Tell the webserver everything is fine
exit (0);



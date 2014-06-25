#!/usr/bin/perl -w
# Remove whitespace at the beginning or end of string

#-----------------------------------------------------------------------------
# Name          : whitespace.pl (script)
# Author        : Michael Kuegeler
# Function      : 
# Date          : 24.06.2014
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
	 
convert_file($infile, $outfile);

}
# end main

#---------------------------------------------------------------------------
# call main
main();
#---------------------------------------------------------------------------
# sub routines
#---------------------------------------------------------------------------
# reads the file which should be transformed into escape characters and converts escape characters

sub convert_file {
	
	
	# input and out files
	my ($filename, $new) = @_; 
	 
	my @data = read_file($filename) ;
	
	my $line;
	
	my $result = "";
	
	my @buffer;
	
	# $text =~ s/^\s+|\s+$//g;
	
	# $text =~ s/^\s*(.*?)\s*$/$1/;
	
	# $text =~ s/^\s+|\s+$//g;
	
	# $text =~ s/\s+//sg;
	
	
	map {$line = $_; $line =~ s/^\s+|\s+$//g; push (@buffer, $line) } @data;
	
	foreach (@buffer) { $result = join ("\n", $result, $_ ); }
	
	# remove first blank line
	$result =~  s/^(?:.*\n){0,1}//;
	
	# remove empty lines
	$result =~ s/\n+/\n/g;
    
	write_file ($new, $result);
    
	# return $result;
	
}

#---------------------------------------------------------------------------
# Tell the webserver everything is fine
exit (0);



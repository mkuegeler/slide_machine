#!/usr/bin/perl -w
# rasterize SVG content to pixel graphics

#-----------------------------------------------------------------------------
# Name          : rasterize.pl (script)
# Author        : Michael Kuegeler
# Function      : 
# Date          : 25.06.2014
# Version       : 1.0
#-----------------------------------------------------------------------------

use strict;
use warnings;

use File::Slurp qw(read_file write_file);

use File::Spec::Functions qw(rel2abs);
use File::Basename;

use XML::LibXML;
use XML::DOM;

use SVG;
use SVG::Rasterize;
# see docs here: https://metacpan.org/pod/SVG%3a%3aRasterize
use SVG::DOM;
use SVG::Parser;



# use Modern::Perl;

our $VERSION = '0.1';

# MAIN
#-----------------------------------------------------------------------------
sub main {

my $svgfile = "out.svg";
my $pngfile = "out.png";

# my $svg = sample_SVG_1();

my $xml = my_DOM_svg();


# Usage: write_svg_file('out.svg', svg-object)
write_svg_file($svgfile,$xml);


my $parser = new SVG::Parser(-debug => 0);
my $svg = $parser->parse($xml);

# Usage: write_raster_file('out.png', svg-object, 640, 480)
write_raster_file($pngfile, $svg, 800, 600);


##############################################################################

# my $value= $svg->getElementByID("svg")->getAttribute("width");
# print $value;

# write SVG File
# write_file ($svgfile, $svg->xmlify(-namespace=>'svg'));


# my $width= $svg->getElementByID("svg")->setAttribute("width", 800);
# my $height= $svg->getElementByID("svg")->setAttribute("height", 600);

# write PNG File 
# my $rasterize = SVG::Rasterize->new();
#   $rasterize->rasterize(svg => $svg, width => 640, height => 480);
#   $rasterize->write(type => 'png', file_name => $pngfile);
	 


}
# end main

#---------------------------------------------------------------------------
# call main
main();
#---------------------------------------------------------------------------
# sub routines
#---------------------------------------------------------------------------
# write svg file
sub write_svg_file {
	
	my ($file, $svg) = @_;
	
	if ((not defined $file) || (not defined $svg))  {
	  die "Incomplete or no parameters! Usage: write_svg_file('out.svg', svg-object)\n";
	            
	}
	
	
	# my $msg =  $file ? write_file ($file, $svg->xmlify(-namespace=>'svg')) : 'Unable to write file!';
	my $msg =  $file ? write_file ($file, $svg) : 'Unable to write file!';
	
	return $msg;
	
	
}

#---------------------------------------------------------------------------
# write raster file

sub write_raster_file {
	
	my ($file, $svg, $width, $height) = @_;
	
	if ((not defined $file) || (not defined $svg) || (not defined $width) || (not defined $height))  {
	  die "Incomplete or no parameters! Usage: write_raster_file('out.png', svg-object, 640, 480)\n";
	           
	}

	my $rasterize = SVG::Rasterize->new();
	   $rasterize->rasterize(svg => $svg, width => $width, height => $height);
	   	
	   
	   my $msg =  $file ? $rasterize->write(type => 'png', file_name => $file) : 'Unable to write file!';
	
	   return $msg;
}



#---------------------------------------------------------------------------
# create a sample SVG (see 1.1.1.svg)
sub sample_SVG_1 {
	
   # create an SVG object
   my $svg= SVG->new(id=>'svg',preserveAspectRatio=>'xMidYMid meet',viewBox=>'0 0 5 3', onclick=>"javascript:location.href='../'", 
   style => {'background-color' => '#ff6600' }
   );
   
   my $desc= $svg->desc()->cdata('This is a description');
   my $style = $svg->style(type=>'text/css')->CDATA('/* custom styles */');
   my $defs = $svg->defs(id=>'template');
   
   
   return $svg;
	   
	   
}

#---------------------------------------------------------------------------
# create a sample SVG (see 3.1.1.svg)

sub sample_SVG_2 {
	
   # create an SVG object
   my $svg= SVG->new(id=>'svg',preserveAspectRatio=>'none',viewBox=>'0 0 5 3', onclick=>"javascript:location.href='../'", 
   style => {'background-color' => '#ff6600' }
   );
   
   my $desc= $svg->desc()->cdata('This is a description');
   my $style = $svg->style(type=>'text/css')->CDATA('/* custom styles */');
   my $defs = $svg->defs(id=>'template');
   
   #my $radialGradient_A = $defs->gradient(-type => "radial", id=>"RadialGradient_A", fx=>"50%", fy=>"50%", r=>"100%", spreadMethod=>"pad");
   
   #my $stop1 = $radialGradient_A->stop(offset=>"0%",  stop-color=>"#ff3300", stop-opacity=>"1");
   #my $stop2 = $radialGradient_A->stop(offset=>"100%",  stop-color=>"#ffcc33", stop-opacity=>"1");
   
   my $group = $svg->g(id=>"layer_0");
   
   # <rect id="frame" width="5" height="3" y="0" x="0" fill="url(#RadialGradient_A)"/>
   
   #my $frame = $group->rect(id=>"frame", width=>"5", height=>"3", y=>"0", x=>"0", fill=>"url(#RadialGradient_A)");
   
           
   return $svg;
	   
	   
}

#---------------------------------------------------------------------------
# create a sample SVG (see 3.1.1.svg) XLM::DOM Version

sub my_DOM_svg {
	
	my $doc = XML::LibXML->createDocument();
	
	my $svg = $doc->createElement("svg");
	$doc->setDocumentElement($svg);
	
	#<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="background-color: #ff6600;"   preserveAspectRatio="xMidYMid meet" viewBox="0 0 5 3" 
	#id="svg" onclick="javascript:location.href='../'">
	
	$svg->setAttributeNode( $doc->createAttribute( "xmlns", "http://www.w3.org/2000/svg") );
	$svg->setAttributeNode( $doc->createAttribute( "xmlns:xlink", "http://www.w3.org/1999/xlink") );
	
	$svg->setAttributeNode( $doc->createAttribute( "id", "svg") );
	
	#$svg->setAttributeNode( $doc->createAttribute( "preserveAspectRatio", "xMidYMid meet") );
	#$svg->setAttributeNode( $doc->createAttribute( "viewBox", "0 0 5 3") );
	
	$svg->setAttributeNode( $doc->createAttribute( "style", "background-color: #ffcc00; stroke-width: 1px; color:#000000") );
	
	$svg->setAttributeNode( $doc->createAttribute( "onclick", "javascript:location.href='../'") );
	
	$svg->setAttributeNode( $doc->createAttribute( "width", "800") );
	$svg->setAttributeNode( $doc->createAttribute( "height", "600") );
	
	my $rect = $doc->createElement("rect");
	
	# <rect id="frame" width="5" height="3" y="0" x="0" fill="url(#RadialGradient_A)"/>
	
	$rect->setAttributeNode( $doc->createAttribute( "id", "frame") );
	$rect->setAttributeNode( $doc->createAttribute( "width", "100") );
	$rect->setAttributeNode( $doc->createAttribute( "height", "100") );
	
	$rect->setAttributeNode( $doc->createAttribute( "x", "10") );
	$rect->setAttributeNode( $doc->createAttribute( "y", "10") );
	
	$rect->setAttributeNode( $doc->createAttribute( "fill", "#0000ff") );
	
	$svg->appendChild($rect);
	
	
	
	
	# remove xml header line
	$doc =~  s/^(?:.*\n){0,1}//;
	
	return $doc;
	
	$doc->dispose;
}


#---------------------------------------------------------------------------
# Tell the webserver everything is fine
exit (0);



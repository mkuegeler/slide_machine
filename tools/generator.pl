#!/usr/bin/perl -w
# generate SVG content

#-----------------------------------------------------------------------------
# Name          : generator.pl (script)
# Author        : Michael Kuegeler
# Function      : 
# Date          : 30.06.2014
# Version       : 1.0
#-----------------------------------------------------------------------------

use strict;
use warnings;

use File::Slurp qw(read_file write_file);

use File::Spec::Functions qw(rel2abs);
use File::Basename;

use XML::LibXML;

use JSON;
use Modern::Perl;

our $VERSION = '0.1';

# MAIN
#-----------------------------------------------------------------------------
sub main {

my $svgfile = "out.svg";
my $jsonfile = "params.json";

my $params = read_json_file($jsonfile);

my $xml = sample_svg_2($params);


# Usage: write_svg_file('out.svg', svg-object)
write_svg_file($svgfile,$xml);

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
	
	my $msg =  $file ? write_file ($file, $svg) : 'Unable to write file!';
	
	return $msg;
	
	
}


#---------------------------------------------------------------------------
# create a sample SVG (see 1.1.1.svg) XLM::DOM Version

sub sample_svg_1 {
	
	my $doc = XML::LibXML->createDocument();
	
	my $svg = $doc->createElement("svg");
	$doc->setDocumentElement($svg);
	
	#<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="background-color: #ff6600;"   preserveAspectRatio="xMidYMid meet" viewBox="0 0 5 3" 
	#id="svg" onclick="javascript:location.href='../'">
	
	$svg->setAttributeNode( $doc->createAttribute( "xmlns", "http://www.w3.org/2000/svg") );
	$svg->setAttributeNode( $doc->createAttribute( "xmlns:xlink", "http://www.w3.org/1999/xlink") );
	
	$svg->setAttributeNode( $doc->createAttribute( "id", "svg") );
	
	$svg->setAttributeNode( $doc->createAttribute( "preserveAspectRatio", "xMidYMid meet") );
	$svg->setAttributeNode( $doc->createAttribute( "viewBox", "0 0 5 3") );
	
	$svg->setAttributeNode( $doc->createAttribute( "style", "background-color: #ffcc00; stroke-width: 1px; color:#000000") );
	
	$svg->setAttributeNode( $doc->createAttribute( "onclick", "javascript:location.href='../'") );
	
	#$svg->setAttributeNode( $doc->createAttribute( "width", "100%") );
	#$svg->setAttributeNode( $doc->createAttribute( "height", "100%") );
	
	#my $rect = $doc->createElement("rect");
	
	# <rect id="frame" width="5" height="3" y="0" x="0" fill="url(#RadialGradient_A)"/>
	
	#$rect->setAttributeNode( $doc->createAttribute( "id", "frame") );
	#$rect->setAttributeNode( $doc->createAttribute( "width", "100") );
	#$rect->setAttributeNode( $doc->createAttribute( "height", "100") );
	
	#$rect->setAttributeNode( $doc->createAttribute( "x", "10") );
	#$rect->setAttributeNode( $doc->createAttribute( "y", "10") );
	
	#$rect->setAttributeNode( $doc->createAttribute( "fill", "#ff0000") );
	
	#$svg->appendChild($rect);
	
	
	
	
	# remove xml header line
	$doc =~  s/^(?:.*\n){0,1}//;
	
	return $doc;
	
	$doc->dispose;
}
#---------------------------------------------------------------------------
# create a sample SVG (see 3.1.1.svg) XLM::DOM Version

sub sample_svg_2 {
	
	
	my $params = shift;
	
	my $doc = XML::LibXML->createDocument();
	
	my $svg = $doc->createElement("svg");
	$doc->setDocumentElement($svg);
	
	#<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="background-color: #ff6600;"   preserveAspectRatio="xMidYMid meet" viewBox="0 0 5 3" 
	#id="svg" onclick="javascript:location.href='../'">
	
	$svg->setAttributeNode( $doc->createAttribute( "xmlns", "http://www.w3.org/2000/svg") );
	$svg->setAttributeNode( $doc->createAttribute( "xmlns:xlink", "http://www.w3.org/1999/xlink") );
	
	$svg->setAttributeNode( $doc->createAttribute( "id", "svg") );
	
	$svg->setAttributeNode( $doc->createAttribute( "preserveAspectRatio", "none") );
	$svg->setAttributeNode( $doc->createAttribute( "viewBox", "0 0 5 3") );
	
	# $svg->setAttributeNode( $doc->createAttribute( "style", "background-color: #ffcc00; stroke-width: 1px; color:#000000") );
	
	$svg->setAttributeNode( $doc->createAttribute( "style", $params->{background_style}) );
	
	
	$svg->setAttributeNode( $doc->createAttribute( "onclick", "javascript:location.href='../'") );
	
	my $desc = $doc->createElement("desc");
	   $desc->setAttributeNode( $doc->createAttribute( "id", "description") );
	   $desc->appendText("A simple svg page with radial gradients and two colors");
    $svg->appendChild($desc);
	
	
	
	my $style = $doc->createElement("style");
	   $style->setAttributeNode( $doc->createAttribute( "type", "text/css") );
	   
	   my $style_content = XML::LibXML::CDATASection->new( "/* custom styles */");
	   #my $style_content = XML::LibXML::Text->new( "<![CDATA[/* custom styles */]]>" );
	   
	   #my @style_content = "<![CDATA[/* custom styles */]]>";
	   
	   $style->appendText($style_content);
       $svg->appendChild($style);
	   
   	my $defs = $doc->createElement("defs");
   	   $defs->setAttributeNode( $doc->createAttribute( "id", "templates") );   
	   
	   $svg->appendChild($defs);   
	   
	 
  	 my $radialGradient = $doc->createElement("radialGradient"); 
	  
  	    $radialGradient->setAttributeNode( $doc->createAttribute( "id", "RadialGradient_A") ); 
  		$radialGradient->setAttributeNode( $doc->createAttribute( "fx", "50%") ); 
  		$radialGradient->setAttributeNode( $doc->createAttribute( "fy", "50%") ); 
  		$radialGradient->setAttributeNode( $doc->createAttribute( "r", "100%") );
  		$radialGradient->setAttributeNode( $doc->createAttribute( "spreadMethod", "pad") );
		
  	     $defs->appendChild($radialGradient);    
	 
   	 my $stop1 = $doc->createElement("stop");
	 
        $stop1->setAttributeNode( $doc->createAttribute( "offset", "0%") );
      	$stop1->setAttributeNode( $doc->createAttribute( "stop-color", $params->{stop_color1}) );
        $stop1->setAttributeNode( $doc->createAttribute( "stop-opacity", "1") );
		
    	$radialGradient->appendChild($stop1);
		
		
     my $stop2 = $doc->createElement("stop");
	 
        $stop2->setAttributeNode( $doc->createAttribute( "offset", "100%") );
        $stop2->setAttributeNode( $doc->createAttribute( "stop-color", $params->{stop_color2}) );
        $stop2->setAttributeNode( $doc->createAttribute( "stop-opacity", "1") );
		
        $radialGradient->appendChild($stop2); 
		
	my $rect = $doc->createElement("rect");	
		
	
	my $g1 = $doc->createElement("g");
	   $g1->setAttributeNode( $doc->createAttribute( "id", "layer_0") );
	
	$svg->appendChild($g1);
	
	$rect->setAttributeNode( $doc->createAttribute( "id", "frame") );
	$rect->setAttributeNode( $doc->createAttribute( "width", "5") );
	$rect->setAttributeNode( $doc->createAttribute( "height", "3") );
	
	$rect->setAttributeNode( $doc->createAttribute( "x", "0") );
	$rect->setAttributeNode( $doc->createAttribute( "y", "0") );
	
	$rect->setAttributeNode( $doc->createAttribute( "fill", "url(#RadialGradient_A)") );
	
	$g1->appendChild($rect);
	
	
	
	
	# remove xml header line
	$doc =~  s/^(?:.*\n){0,1}//;
	
	return $doc;
	
	$doc->dispose;
}

# ---------------------------------------------------------------------------
# read,update write json from and to file
# read a file into hash, update hash, save hash back to file

sub read_json_file {
	
	my $filename = shift; 
	my $json = -e $filename ? read_file $filename : '{}';
    
	return from_json $json;
	
}

#---------------------------------------------------------------------------
# Tell the webserver everything is fine
exit (0);



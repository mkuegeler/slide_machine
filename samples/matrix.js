/**
 * matrix.js

 * based on Template library 1.0 (template.js)
 * Michael Kuegeler 12/2013
 * 
 * * Copyright 2013-2014 Michael Kuegeler
 * 
 * this is just a template to be used for custom libraries
 */
///////////////////////////////////////////////////////////////////////////////
function Matrix ()
{
	
	
	this.xmlns = "http://www.w3.org/2000/svg";
	this.xlinkNS = "http://www.w3.org/1999/xlink"; 	

	// a random generated id value by default
	this.id = Math.random().toString();
	
	// the parent node of the Matrix. If not defined than defs element
	this.layer = document.getElementsByTagName("defs").item(0).id;
	
	
	
	
	
}
///////////////////////////////////////////////////////////////////////////////
// Global functions used in symbol libraries
///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.setNS = function(value)
{
            this.xmlns = value;
}
Matrix.prototype.getNS = function()
{
            return this.xmlns;
} 
///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.setxlinkNS = function(value)
{
            this.xlinkNS = value;
}
Matrix.prototype.getxlinkNS = function()
{
            return this.xlinkNS;
}

///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.setID = function(value)
{
            this.id = value;
}
Matrix.prototype.getID = function()
{
            return this.id;
}

///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.setLayer = function(value)
{
            this.layer = value;
}
Matrix.prototype.getLayer = function()
{
            return this.layer;
}


///////////////////////////////////////////////////////////////////////////////
// SUPPORT functions
///////////////////////////////////////////////////////////////////////////////
// Create a "Use" element
///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.use = function(params)
{
	
	var use = document.getElementById(params.href);	
	
	var use = document.createElementNS(this.getNS(),"use"); 
	    
	    use.setAttributeNS(this.getxlinkNS(),"xlink:href","#"+params.href); 	    
	    
	    use.setAttribute("transform",params.transform);
	    
	    this.setLayer(params.parent);
        
        document.getElementById(this.getLayer()).appendChild(use);
     
}

///////////////////////////////////////////////////////////////////////////////
// MAIN: Start
// add your custom functions here
///////////////////////////////////////////////////////////////////////////////
// 1. a simple circle  
Matrix.prototype.addCircle = function(params)
{
 	// var params = {parent: "layer",id:"id", r: 1, cx:1, cy:1, class: "class"};
 	
    var circle = document.createElementNS(this.getNS(),"circle");

        circle.setAttribute("cx",params.cx); 
        circle.setAttribute("cy",params.cy);                
        circle.setAttribute("r",params.r);
        // circle.setAttribute("style",style);		
	    circle.setAttribute("class",params.class);	
	    // circle.setAttribute("onmouseover","alert('test')")
	    
	    this.setLayer(params.parent);
	    			
        document.getElementById(this.getLayer()).appendChild(circle);
     
} 
// 2. a simple circle symbol 
Matrix.prototype.simpleCircleSymbol = function(params)
{
    // var params = {id:"id", r: 1, cx:1, cy:1, class: "class"};
    
	var symbol = document.createElementNS(this.getNS(),"symbol"); 
	    symbol.setAttribute("id",params.id);	
	

	var group = document.createElementNS(this.getNS(),"g");
	
    var circle = document.createElementNS(this.getNS(),"circle");

        circle.setAttribute("cx",params.cx); 
        circle.setAttribute("cy",params.cy);                
        circle.setAttribute("r",params.r);
        // circle.setAttribute("style",style);		
	    circle.setAttribute("class",params.class);	
		
	    group.appendChild(circle);	
	    symbol.appendChild(group);
	    			
        document.getElementById(this.getLayer()).appendChild(symbol);
     
} 

///////////////////////////////////////////////////////////////////////////////
// 2. a simple rectangle
Matrix.prototype.simpleRectSymbol = function(params)
{
    
 	
	var symbol = document.createElementNS(this.getNS(),"symbol"); 
	    symbol.setAttribute("id",params.id);

	var group = document.createElementNS(this.getNS(),"g");
	
    var rect = document.createElementNS(this.getNS(),"rect");

        rect.setAttribute("x",params.x);
        rect.setAttribute("y",params.y);

	    rect.setAttribute("width",params.width);
        rect.setAttribute("height",params.height); 

        rect.setAttribute("rx",params.rx);
		rect.setAttribute("ry",params.ry);
		
	    rect.setAttribute("class",params.style);	
	    group.appendChild(rect);	
	
	    symbol.appendChild(group);
	    			
        document.getElementById(this.getLayer()).appendChild(symbol);
     
}


///////////////////////////////////////////////////////////////////////////////
// MAIN: End
///////////////////////////////////////////////////////////////////////////////
// initialize the library in SVG file
// get parameters and create initial object canvas
// init can be called in svg root node: onload="new Matrix().init(evt)"
// currently, init() is defined in the svg file directly.
///////////////////////////////////////////////////////////////////////////////
Matrix.prototype.init = function()
{
	
var Matrix = new Matrix();

// exampple:
// initialize the object
// Matrix.simpleCircleSymbol("symbol_1");

// use object in svg file:
// new Matrix().use("symbol_1","translate(0,0)"); 


}
///////////////////////////////////////////////////////////////////////////////

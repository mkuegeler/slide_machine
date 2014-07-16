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
	
	// default parameters for each element
	this.circle = {r: 1, cx:1, cy:1};
	this.rect =   {width: 10,height: 20,x:0,y:0,rx:0.1,ry:0.1};
	this.text =   {x:10,y:10};
	
	this.value = "void";
	
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
///////////////////////////////////////////////////////////////////////////////

// set and get default params
///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.setParams = function(params)
{
            
            
     switch (params.type) {
		
	       case "circle": this.circle = params;
	       break;
	   
	       case "rect": this.rect = params;
	       break;
	   
	       case "text": this.text = params;
	       break;
	   
   }       
            
}
Matrix.prototype.getParams = function(type)
{
           switch (type) {
		
	       case "circle": return this.circle;
	       break;
	   
	       case "rect": return this.rect;
	       break;
	   
	       case "text": return this.text;
	       break;
	   
   }        
}

Matrix.prototype.showParams = function(params)
{
    
       Object.keys(params).forEach(function(key) {
        console.log(key + ' => ' + params[key]);
       }); 

}


Matrix.prototype.setValue = function(key,value, params)
{
         
            if (params[key]) { this.value = params[key]; }
            else {this.value = value; }

}

Matrix.prototype.getValue = function()
{
            return this.value;
}


///////////////////////////////////////////////////////////////////////////////
// Event helper
///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.setEvent = function(params)
{
      
      var el = document.getElementById(params.id);
      
      switch (el.tagName) {
		
	       case "circle": 
		  
		   alert('A circle'); 
	       break;
	   
	       case "rect": 
		    
	       alert('A rectangle'); 
	       break;
	   
	       case "text":

	       alert('A text'); 
	       break;
	   
      }
  
      // debug only
      // console.log(type);  
}



///////////////////////////////////////////////////////////////////////////////
// Create a "Use" element
///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.Use = function(params)
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
// 1. a generic Element

Matrix.prototype.Element = function(params)
{
 	
 	// var params = {type:'circle', parent: 'el_1',id:'id_1', r: 1, cx:1, cy:1, style: 'stroke:#ff0000; stroke-width:0.15; fill:#00ffff;'};
 	
    var defaults = this.getParams(params.type);

    var obj = document.createElementNS(this.getNS(),params.type);
    
    if (params.type == 'text') {
    	var data;
    	if (params.data) {data = params.data; } else {data = "text"; }
    	     obj.appendChild(document.createTextNode(data));
    }
    
    
    for (key in defaults) {
    	this.setValue(key, defaults[key], params);
        obj.setAttribute(key, this.getValue() );
    }; 
    
		// either style or class is required
		if (params.class) {
			obj.setAttribute("class",params.class);
		} else {obj.setAttribute("style",params.style);}
	    	
	        
	       var json = JSON.stringify(params);
        obj.setAttribute("onclick","new Matrix().setEvent("+json+")"); 
	    
		
	    if (params.parent) {
		    obj.setAttribute("id",params.id); 
			this.setLayer(params.parent);
			document.getElementById(this.getLayer()).appendChild(obj);
	    } else {  var symbol = document.createElementNS(this.getNS(),"symbol"); 
		              symbol.setAttribute("id",params.id);  
					  symbol.appendChild(obj);
					  document.getElementById(this.getLayer()).appendChild(symbol);
				  }
     
} 

///////////////////////////////////////////////////////////////////////////////
// 2. a simple circle  
Matrix.prototype.Circle = function(params)
{
 	
 	// var params1 = {parent: 'el_1',id:'id_1', r: 1, cx:1, cy:1, style: 'stroke:#ff0000; stroke-width:0.15; fill:#00ffff;'};
    // var params2 = {id:'id_1', r: 1, cx:1, cy:1, class: 'node_2'};

    var obj = document.createElementNS(this.getNS(),"circle");
  
        obj.setAttribute("cx",params.cx); 
        obj.setAttribute("cy",params.cy);                
        obj.setAttribute("r",params.r);
        // circle.setAttribute("style",style);
		
		// either style or class is required
		if (params.class) {
			obj.setAttribute("class",params.class);
		} else {obj.setAttribute("style",params.style);}
	    	
	        
	       var json = JSON.stringify(params);
        obj.setAttribute("onclick","new Matrix().setEvent("+json+")"); 
	    
		
	    if (params.parent) {
		    obj.setAttribute("id",params.id); 
			this.setLayer(params.parent);
			document.getElementById(this.getLayer()).appendChild(obj);
	    } else {  var symbol = document.createElementNS(this.getNS(),"symbol"); 
		              symbol.setAttribute("id",params.id);  
					  symbol.appendChild(obj);
					  document.getElementById(this.getLayer()).appendChild(symbol);
				  }
     
} 

///////////////////////////////////////////////////////////////////////////////
// 3. a simple rectangle  
Matrix.prototype.Rect = function(params)
{
 	
 	// var params3 = {parent: 'layer_0',id: 'rect_1',width: 10,height: 20,x:0,y:0,rx:0.1,ry:0.1,class:'col_1'};
    // var params4 = {id: 'rect_1',width: 10,height: 20,x:0,y:0,rx:0.1,ry:0.1,style: 'stroke:#ff0000; stroke-width:0.15; fill:#00ffff;'};
   
    var rect = document.createElementNS(this.getNS(),"rect");
  
        rect.setAttribute("x",params.x);
        rect.setAttribute("y",params.y);

	    rect.setAttribute("width",params.width);
        rect.setAttribute("height",params.height); 

        rect.setAttribute("rx",params.rx);
		rect.setAttribute("ry",params.ry);
		
		// either style or class is required
		if (params.class) {
			rect.setAttribute("class",params.class);
		} else {rect.setAttribute("style",params.style);}
		
		var json = JSON.stringify(params);
        rect.setAttribute("onclick","new Matrix().setEvent("+json+")"); 
		
		
	    if (params.parent) {
		    rect.setAttribute("id",params.id); 
			this.setLayer(params.parent);
			document.getElementById(this.getLayer()).appendChild(rect);
	    } else {  var symbol = document.createElementNS(this.getNS(),"symbol"); 
		              symbol.setAttribute("id",params.id);  
					  symbol.appendChild(rect);
					  document.getElementById(this.getLayer()).appendChild(symbol);
				  }
     
} 

///////////////////////////////////////////////////////////////////////////////

Matrix.prototype.Text = function(params)
{
	
	var text = document.createElementNS(this.getNS(),"text");
	var textnode = document.createTextNode(params.data);
	
	    text.setAttribute("x",params.x);
        text.setAttribute("y",params.y);
        
        // either style or class is required
		if (params.class) {
			text.setAttribute("class",params.class);
		} else {text.setAttribute("style",params.style);}
        
        text.appendChild(textnode);
        
        var json = JSON.stringify(params);
        text.setAttribute("onclick","new Matrix().setEvent("+json+")");
	    
        
        if (params.parent) {
		    text.setAttribute("id",params.id); 
			this.setLayer(params.parent);
			document.getElementById(this.getLayer()).appendChild(text);
	    } else {  var symbol = document.createElementNS(this.getNS(),"symbol"); 
		              symbol.setAttribute("id",params.id);  
					  symbol.appendChild(text);
					  document.getElementById(this.getLayer()).appendChild(symbol);
				  }
		
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
	
var matrix = new Matrix();

// Example Usage in SVG script tag:
// var params3 = {parent: 'layer_0',id: 'rect_1',width: 10,height: 20,x:0,y:0,rx:0.1,ry:0.1,class:'col_1'};
// var params4 = {id: 'rect_1',width: 10,height: 20,x:0,y:0,rx:0.1,ry:0.1,style: 'stroke:#ff0000; stroke-width:0.15; fill:#00ffff;'};
// matrix.Rect(params4);

// matrix.Use({parent: "layer_0", href: "rect_1", transform: "translate(0,0)"}); 


}
///////////////////////////////////////////////////////////////////////////////

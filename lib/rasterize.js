var page = require('webpage').create(),
	system= require( 'system'),
    address, output, size;

if (phantom.args.length != 5) {
    console.log('Usage: rasterize.js URL filename width height zoom');
    phantom.exit();
} else {
    address = phantom.args[0];
    output = phantom.args[1];
    width_param = phantom.args[2];
    height_param = phantom.args[3];
    zoom = phantom.args[4]


	//set viewpoort if it is there
	/*
	if (width_param != "none") {
		page.viewportSize = { width: width_param, height: height_param };
	
	}*/
	page.paperSize = "landscape"  
	page.viewportSize = { width: width_param, height: height_param };
   	
   	
  
    page.open(address, function (status) {
        if (status !== 'success') {
            console.log('Unable to load the address!');
        } else {
  	
  			//CLIP RECT DOESN'T WORK WITH PDF GENERATION
  			      	
  	
        
       // page.viewportSize = { width: width, height: height };
	//	page.viewportSize = { width: width};
		
     //   page.clipRect = { top: 0, left: 0, width: 30, height: 30 };
        
      //    page.clipRect = { top: 0, left: 0, width: 960, height: 800 };
          
         
            window.setTimeout(function () {
				
				console.log( 'rendering');
            	page.zoomFactor = zoom;
            	//page.clipRect = { top: 0, left: 0, width: width, height: height };
            	
                page.render(output);
                phantom.exit();
            }, 200);
        }
    });
}
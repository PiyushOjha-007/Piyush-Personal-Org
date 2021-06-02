({
	handleCapture : function(component, event, helper) {
		console.log('I am Parent Component');
        var mytext = event.getParam("mytext");
        console.log(' In Parent Component '+mytext);
	}
})
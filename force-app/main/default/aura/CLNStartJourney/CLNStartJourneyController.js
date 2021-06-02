({
	OncheckboxSelect : function(component, event, helper) {
		var selectedRec = event.getSource().get("v.value");
        var chkbox1   = component.find('Box1').get("v.value");
        var chkbox2   = component.find('Box2').get("v.value");
       alert(chkbox1+' and '+chkbox2);
        var chk = 0;
        if(selectedRec)
        {
            chk = chk + 1;
            alert('Hi:'+chk);
        }
         else
                  {
                      chk = chk -1 ;
                     alert('Hello:'+chk);
                  }
        
	}
})
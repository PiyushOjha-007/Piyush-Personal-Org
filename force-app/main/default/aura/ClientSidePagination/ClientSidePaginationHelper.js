({
    getAllAccounts : function(cmp,event) {
        var actionAccount = cmp.get("c.getAccList");
        actionAccount.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var pageSize = cmp.get("v.pageSize");
                console.log('Here 2');
                var accList = [];
                var resultData = response.getReturnValue();
                cmp.set("v.allData",resultData);
                for(var i = 0; i< pageSize ; i++)
                {
                    if(resultData.length > i)
                    {
                        accList.push(resultData[i]);
                    }
                    else
                    {
                        cmp.set("v.lessRecords",true);
                    }
                }
                cmp.set("v.data",accList);
                var SuccesstoastEvent = $A.get("e.force:showToast");
                SuccesstoastEvent.setParams({
                    title : 'Success Message',
                    message: 'Congatulations , The Requested Records Successfully Fetched .',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                SuccesstoastEvent.fire();
            }
            if(cmp.get("v.lessRecords") == true)
            {
                var ErrortoastEvent = $A.get("e.force:showToast");
                ErrortoastEvent.setParams({
                    title : 'Error Message',
                    message: 'Records are less than the Page Size / Something Unexpected Occurred !',
                    duration:' 4000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                ErrortoastEvent.fire();
            }
        });
        $A.enqueueAction(actionAccount);
    },
    onNextClick : function(cmp,event) {
        var allRecords = cmp.get("v.allData");	
        var pageSize = cmp.get("v.pageSize");
        var fpage = cmp.get("v.firstPage");
        var displayRecords = [];
        
        
        for(var i = (fpage*pageSize) ; i< (fpage*pageSize+pageSize) ; i++)
        {
            console.log('Here :',i);
            if(allRecords.length > i)
            displayRecords.push(allRecords[i]);
            else
               cmp.set("v.isLastPage",true); 
        }
            
        console.log('Records :#',JSON.stringify(displayRecords));
        cmp.set("v.data",displayRecords);
        cmp.set("v.firstPage",fpage+1);
    },
    onPreviousClick : function(cmp,event)
    {
 		var allRecords = cmp.get("v.allData");	
        var pageSize = cmp.get("v.pageSize");
        var prevpage = cmp.get("v.firstPage");
        alert('Previous Page',prevpage);
        var displayRecords = [];
        for(var i = (fpage*pageSize+pageSize) ; i > (fpage*pageSize) ; i--)
        {
            console.log('Here :',i);
            displayRecords.push(allRecords[i]);
            
        }
        cmp.set("v.data",displayRecords);
        cmp.set("v.firstPage",prevpage-1);
    }
})
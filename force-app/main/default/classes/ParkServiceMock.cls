@isTest
global class ParkServiceMock implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        
               ParkService.byCountryResponse obj = new ParkService.byCountryResponse();
               obj.return_x = new List<String>{'Panna National Park','Kanha National Park'};
               response.put('response_x', obj) ;   
                   
   }
}
public class ParkLocator {

    public static String[] country(String args)
    {
        
        String[] newStr;
        ParkService.ParksImplPort obj = new ParkService.ParksImplPort();
        newStr = obj.byCountry(args);
        return newStr;
    }
}
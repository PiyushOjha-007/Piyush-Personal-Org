public class UserInfoController {
   @AuraEnabled 
    public static List<User> getUserInfo(){
       List<User> lstOfUser = [Select id,name from User];
     /*   List<String> userList = new List<String>();
        for(User u : lstOfUser)
        {
            userList.add(u.Name);
        }
*/
        return lstOfUser;
    }
}
package Data;

import com.github.javafaker.Faker;

public class DataGenerator {
    public static String getEmail(){
        //String email = "shafagh_";
        //int random = (int) (Math.random() * 88736);
        //return email + random + "@tekschool.us";
        Faker faker = new Faker();
        return faker.name().firstName() + faker.name().lastName() + "@tekschool.us";
    }
    public static String getFirstName(){
        //char[] alphabet = {'A', 'B', 'C', 'D', 'E', 'F'};
        //String name = "";
        //for (int i = 0 ; i< 5 ; i++){
           // int index = (int)(Math.random() * alphabet.length);
          //  name += alphabet[index];
        //  return name;}
        Faker faker = new Faker();
        return faker.name().firstName();



    }
    public static String getLastName() {
        Faker faker = new Faker();
        return faker.name().lastName();
    }

    public static String getPosition() {
        Faker faker = new Faker();
        return faker.job().position();
    }

}

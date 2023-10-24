package runners;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
    @Karate.Test
    Karate run(){
        return Karate.run("classpath:features")
        .tags("@End2End")
        .karateEnv("qa");


    }
}

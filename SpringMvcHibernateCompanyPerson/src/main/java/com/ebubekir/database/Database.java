package com.ebubekir.database;

import com.ebubekir.entities.Person;
import com.ebubekir.service.PersonManager;
import com.github.javafaker.Faker;

public class Database {

    public static void initializeDatabase() {

        PersonManager personManager = new PersonManager();
        Faker faker = new Faker();

        // TODO Adding Customers
        for (int i = 0; i < 10; i++) {
            Person customer = new Person();
            customer.setFirstname(faker.name().firstName());
            customer.setLastname(faker.name().lastName());
            customer.setEmail(faker.internet().emailAddress());
            customer.setPhoneNumber(faker.numerify("###-###-####"));

            personManager.insert(customer);
        }
    }
}

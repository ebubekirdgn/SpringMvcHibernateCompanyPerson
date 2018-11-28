package com.ebubekir;

import com.ebubekir.database.Database;

import javax.servlet.ServletContextEvent;

public class ServletListener implements javax.servlet.ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Database.initializeDatabase();
    }
}

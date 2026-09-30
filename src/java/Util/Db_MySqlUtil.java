
package Util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Db_MySqlUtil
{    
    public static Connection getConnection()
    {
        Connection connection = null;
//        Logger log = Logger.getLogger("FAB");
        try
        {
            Properties prop = new Properties();
            InputStream inputStream = null;
            inputStream = Db_MySqlUtil.class.getClassLoader().getResourceAsStream("Db_MySql.properties");
            prop.load(inputStream);
            String driver = prop.getProperty("driver");
            String url = prop.getProperty("url");
            String user = prop.getProperty("user");
            String password = prop.getProperty("password");
            Class.forName(driver);
            connection = DriverManager.getConnection(url, user, password);
            
            if (inputStream != null)
                inputStream.close();
        }catch (ClassNotFoundException | SQLException | IOException e)
        {
//            log.error("ClassNotFoundException "+e.toString());
            e.getMessage();
        }
//            log.error("FileNotFoundException "+e.toString());
//            log.error("IOException "+e.toString());
//            log.error("IOException "+e.toString());
        return connection;
    }    
    
}

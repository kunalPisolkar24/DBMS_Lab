 
import java.sql.*;
public class p9 {
    private static final String jdbcUrl = "jdbc:mysql://localhost:3306/test1";
    private static final String uname = "root";
    private static final String password = "Kunal@123";


    public static void main(String[] args) throws Exception {
        Connection con = DriverManager.getConnection(jdbcUrl, uname, password);
        if(con != null) {
            System.out.println("Connection Successful");


        }
    }

    private static void createTable(Connection con) {
        String query = "CREATE TABLE users( id int auto_increment primary key, name varchar(255))";
        PreparedStatement prepCon = con.prepareStatement(query);
        prepCon.execute();
        System.out.println("Table Created");
    }

    private static int insertData(Connection con)

    public static void main(String[] args) throws Exception {
        Connection con = DriverManager.getConnection(jdbcUrl, uname, password);
        if(con != null) {
            System.out.println("Connection Successful!");

            createTable(con);

            insertData(con, "Rahul", "Gandhi");
            insertData(con, "Yogi", "Aditya Nath");
            updateData(con, 1, "Rahul", "Modi");
            deleteData(con, 1);
            readData(con);

        }
    }

    private static void createTable(Connection con) throws Exception{
        String query = "CREATE TABLE IF NOT EXISTS users ( id int auto_increment primary key,fname varchar(50), lname varchar(50));";
        PreparedStatement prepCon = con.prepareStatement(query);
        prepCon.execute();
        System.out.println("Table created");
    }

    private static int insertData(Connection con, String fn, String ln) throws Exception {
        String query = "INSERT INTO users(fname, lname) VALUES(?, ?)";
        PreparedStatement prepCon = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
        prepCon.setString(1, fn);
        prepCon.setString(2, ln);
        prepCon.executeUpdate();

        ResultSet genKey = prepCon.getGeneratedKeys();
        if(genKey.next()) {
            int id = genKey.getInt(1);
            System.out.println("Insert Successful with id : " + id);
            return id;
        }
        return -1;
    }

    private static void updateData(Connection con, int id, String fn, String ln) throws Exception {
        String query = "UPDATE users SET fname = ?, lname = ? where id = ?";
        PreparedStatement prepCon = con.prepareStatement(query);
        prepCon.setString(1, fn);
        prepCon.setString(2, ln);
        prepCon.setInt(3, id);
        prepCon.executeUpdate();
        System.out.println("Data updated for id : " + id );
    }

    private static void deleteData(Connection con, int id) throws Exception {
        String query = "DELETE FROM users WHERE id = ?";
        PreparedStatement prepCon = con.prepareStatement(query);
        prepCon.setInt(1, id);
        System.out.println("Data deleted for Id : " + id);
    }

    private static void readData(Connection con) throws Exception{
        String query = "SELECT id, fname, lname FROM users";
        PreparedStatement prepCon = con.prepareStatement(query);
        ResultSet res = prepCon.executeQuery();
        System.out.println("User Data: ");
        while(res.next()) {
            int id = res.getInt("id");
            String fn = res.getString("fname");
            String ln = res.getString("lname");
            System.out.println("ID: " + id +" Name: " + fn + " " + ln);
        }
    }
};

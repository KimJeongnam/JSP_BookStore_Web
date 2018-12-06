
커넥션 풀:
<Resource auth="Container"
        name="jdbc/Oracle11g_bookstore"
        driverClassName="oracle.jdbc.driver.OracleDriver"
        type="javax.sql.DataSource"
        url="jdbc:oracle:thin:@localhost:1521:xe"
        maxActive="50"
        maxWait="1000"
        username="jeongnam_bookstore"
        password="tiger"
    />
package fr.myproject.test;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

public class DBAndScriptFlywayAndRequestTest {

    private static final Logger log = LoggerFactory.getLogger(DBAndScriptFlywayAndRequestTest.class);
    private DataSource dataSource;

    @BeforeEach
    void setUp() throws SQLException {

        // dataSource
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;MODE=PostgreSQL");
        config.setUsername("sa");
        config.setPassword("");
        dataSource = new HikariDataSource(config);

        Flyway flyway = Flyway.configure()
                .dataSource(dataSource)
                .locations("classpath:db/migration")
                .schemas("public")
                .load();

        // clean db
        flyway.clean();

        // create tables
        flyway.migrate();

        // check connection
        try (var conn = dataSource.getConnection()){
            assertTrue(conn.isValid(1000));
        }
    }

    @Test
    void testBasicConnection() {
        try (var connection = dataSource.getConnection()){
            var preparedStatement = connection.prepareStatement("SELECT COUNT(*) FROM Auteurs");
            try (var rs = preparedStatement.executeQuery()){
                rs.next();
                assertTrue(rs.getInt(1)>=0);
            }
        } catch (SQLException e) {
            fail(e.getMessage());
        }
    }
}

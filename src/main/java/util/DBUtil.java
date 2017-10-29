package util;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import org.apache.commons.dbcp.BasicDataSource;

/**
 * 数据库连接的管理
 *
 */
public class DBUtil {
	
	private static BasicDataSource dataSource;
	
	static{
		try {
			Properties properties = new Properties();
			//new FileInputStream("config.properties")
			/*
			 * DBUtil.class.getClassLoader()
			 * 获得加载DBUtil的类加载器（Classloader）.
			 * 
			 * getResourceAsStream()是类加载其提供的方法
			 * 会依据类路径去查找属性文件（.properties文件），
			 * 然后返回InputStream
			 */
			properties.load(DBUtil.class.getClassLoader().getResourceAsStream("dbconfig/config.properties"));
			
			String driverclass = properties.getProperty("driverclass");
			String url = properties.getProperty("url");
			String username = properties.getProperty("username");
			String password = properties.getProperty("password");
			int maxActive = Integer.parseInt(properties.getProperty("maxactive"));
			int maxWait = Integer.parseInt(properties.getProperty("maxwait"));
			int maxIdle = Integer.parseInt(properties.getProperty("maxIdle"));
			
			dataSource = new BasicDataSource();
			dataSource.setDriverClassName(driverclass);
			dataSource.setUrl(url);
			dataSource.setUsername(username);
			dataSource.setPassword(password);
			//设置最大连接数
			dataSource.setMaxActive(maxActive);
			//设置最大等待时间
			dataSource.setMaxWait(maxWait);
			//连接池中最多可空闲maxIdle个连接
			dataSource.setMaxIdle(maxIdle);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 或取一个数据库连接
	 * @return Connection 对象
	 */
	public static Connection getConnection() throws SQLException{
		try {
			/*
			 * 向连接池获取连接
			 * 若连接池中没有可用连接时，该方法会阻塞当前线程，阻塞时间由连接池设置的maxWait决定。
			 * 当阻塞过程中连接池有啦可用连接时，会立即将连接返回。
			 * 若超时仍然没有可用连接，则该方法会抛出异常
			 * 
			 */
			return dataSource.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 关闭连接
	 * @param connection
	 */
	public static void closeConnection(Connection connection){
		try {
			if (connection!=null) {
				connection.setAutoCommit(true);
				/*
				 * 连接池的连接对于close方法的处理是将连接的状态设置为空闲，而非真的关闭！
				 */
				connection.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}

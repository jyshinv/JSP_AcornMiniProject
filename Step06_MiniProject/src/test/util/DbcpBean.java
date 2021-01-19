package test.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/*
 *  [ Data Base Connection Pool Bean ]
 *  
 *  아래의 클래스가 동작 하려면 
 *  
 *  1. Servers/context.xml 문서에 DB 접속 정보가 있어야 한다.
 *  
 *  <Resource name="jdbc/myoracle" auth="Container"
              type="javax.sql.DataSource" driverClassName="oracle.jdbc.OracleDriver"
              url="jdbc:oracle:thin:@127.0.0.1:1521:xe"
              username="scott" password="tiger" maxTotal="20" maxIdle="10"
              maxWaitMillis="-1"/>
    
    2. 프로젝트의 WEB-INF/web.xml 문서에 아래의 설정이 있어야 한다.
    <resource-ref>
		<description>Oracle Datasource example</description>
		<res-ref-name>jdbc/myoracle</res-ref-name>
		<res-type>javax.sql.DataSource</res-type>
		<res-auth>Container</res-auth>
	</resource-ref>
	
	3. WEB-INF/lib/ 폴더에 ojdbc6.jar 파일을 넣어서 라이브러리를 사용할 준비를 해야한다.
	
	위의 3가지 설정을 한후에 
	
	- new DbcpBean().getConn() 메소드를 호출하면 Connection Pool 에서 
	Connection 객체가 하나 리턴된다. 
	
	- Dao 에서 Connection 객체를 사용한후 .close() 메소드를 호출하면 
	  자동으로 Connection Pool 에 Connection 객체가 반환된다.
	
 */

public class DbcpBean {
	
	//복붙 후 ctrl+shitf+o로 일괄 import 후 아래와 같은 형태로 만들어준다. 
	//필드
	private Connection conn;
	//생성자
	public DbcpBean() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			//얻어온 Connection 객체의 참조값을 필드에 저장한다.
			conn = ds.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//Connection 객체를 리턴해주는 메소드
	public Connection getConn() {
		return conn;
	}

}

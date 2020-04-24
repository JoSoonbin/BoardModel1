package com.board.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class CommonDao {
	private final String driverName = "oracle.jdbc.driver.OracleDriver";
	private final String url = "jdbc:orcle:thin:@localhost:1521:XE";
	private final String db_id = "hr";
	private final String db_pw = "hr";
	
	// 접속에 필요한 변수를 선언
	private Connection con = null;
	private Statement stmt = null;
	
	// db 접속정보를 가지고,
	// 접속후에 sql문을 사용하기 위해 필요한 statement객체를 반환
	public Statement openConnection() {
		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(url, db_id, db_pw);
			stmt = con.createStatement();
		}catch(Exception e) {
			System.err.println("Oracle Database Connection Something Problem!!");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return stmt;
	}
	
	public void closeConnection() {
		try {
			if(!con.isClosed())
				con.close();
		}catch (SQLException e ) {
			e.printStackTrace();
		}
	}
}

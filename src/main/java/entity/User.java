package entity;

import java.util.List;

public class User extends BaseBean {
	/*
	 * id varchar2(32) primary key, nickname varchar2(100) , realname
	 * varchar2(30), password varchar2(100) , email varchar(128) , status
	 * varchar2(2) default '0' check(status in('0','1')),--0代表可登录，1代表被禁止登录
	 * last_login_time timestamp ,
	 */
	private String id;
	private String nickname;
	private String realname;
	private String password;
	private String email;
	private String status;
	private String last_login_time;
	private List<Role> roles;
	private List<Permission> permissions;

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}

	public List<Permission> getPermissions() {
		return permissions;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLast_login_time() {
		return last_login_time;
	}

	public void setLast_login_time(String last_login_time) {
		this.last_login_time = last_login_time;
	}

	/**
	 * @param nickname
	 * @param realname
	 * @param password
	 * @param email
	 * @param status
	 * @param last_login_time
	 */
	public User(String nickname, String realname, String password, String email, String status) {
		this.nickname = nickname;
		this.realname = realname;
		this.password = password;
		this.email = email;
		this.status = status;
	}

	/**
	 * @param id
	 * @param nickname
	 * @param realname
	 * @param password
	 * @param email
	 * @param status
	 * @param last_login_time
	 */
	public User(String id, String nickname, String realname, String password, String email, String status) {
		this.id = id;
		this.nickname = nickname;
		this.realname = realname;
		this.password = password;
		this.email = email;
		this.status = status;
	}

	public User() {

	}

	@Override
	public String toString() {
		return "User [id=" + id + ", nickname=" + nickname + ", realname=" + realname + ", password=" + password
				+ ", email=" + email + ", status=" + status + ", last_login_time=" + last_login_time + ", roles="
				+ roles + ", permissions=" + permissions + "]";
	}

	

}

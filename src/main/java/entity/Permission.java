package entity;

public class Permission extends BaseBean {
	 /* id varchar2(32)  primary key,
	  url varchar(500) ,
	  name varchar(100) ,*/
	private String id;
	private String url;
	private String name;
	/**
	 * @param id
	 * @param url
	 * @param name
	 */
	public Permission(String id, String url, String name) {
		this.id = id;
		this.url = url;
		this.name = name;
	}
	/**
	 * @param url
	 * @param name
	 */
	public Permission(String url, String name) {
		this.url = url;
		this.name = name;
	}
	/**
	 * 
	 */
	public Permission() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Permission [id=" + id + ", url=" + url + ", name=" + name + "]";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}

package entity;

import java.util.List;

public class Role extends BaseBean{
	private String id;
	private String roleName;
	private String roleType;
	private List<Permission> permissions;
	
	public List<Permission> getPermissions() {
		return permissions;
	}
	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	
	public Role() {
	}
	/**
	 * @param id
	 * @param roleName
	 * @param roleType
	 */
	public Role(String id, String roleName, String roleType,List<Permission> permissions) {
		this.id = id;
		this.roleName = roleName;
		this.roleType = roleType;
		this.permissions = permissions;
	}
	/**
	 * @param roleName
	 * @param roleType
	 */
	public Role(String roleName, String roleType,List<Permission> permissions) {
		this.roleName = roleName;
		this.roleType = roleType;
		this.permissions = permissions;
	}
	@Override
	public String toString() {
		return "Role [id=" + id + ", roleName=" + roleName + ", roleType=" + roleType + ", permissions=" + permissions
				+ "]";
	}
	
	
}

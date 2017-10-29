package dao;

import java.util.List;


import entity.Role;

public interface RoleDao{
	public void saveRole(Role role);
	public void deleteRoleById(String id);
	public Role findRoleById(String id);
	public List<Role> findAll(int page,int rows,String sname);
	public List<Role> findRolesByNameOrByType(String nameOrType);
	public void updateRole(Role role);
	public void updateRolePermission(String roleId, String[] string);
	public int getSize();
}

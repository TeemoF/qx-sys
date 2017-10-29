package dao;

import java.util.List;

import entity.Permission;
import entity.Role;

public interface BaseDao {
	public List<Permission> findPsermissionsByRoleId(String roleId);
	public List<Role> findRolesByUserId(String userId);
	
}

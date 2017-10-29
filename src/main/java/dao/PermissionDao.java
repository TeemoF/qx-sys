package dao;

import java.util.List;

import entity.Permission;

public interface PermissionDao{
	public void savePermission(Permission permission);
	public void deletePermissionById(String id);
	public Permission findPermissionById(String id);
	public void updatePermission(Permission permission);
	public List<Permission> findAll(int page,int rows,String info);
	public List<Permission> findAll();
	public List<Permission> findPermissionByName(String permissionName);
	public int getSize();
}

package dao.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.junit.Test;

import dao.BaseDao;
import entity.Permission;
import entity.Role;
import util.DBUtil;
import util.DateUtil;

public class BaseDaoImp implements BaseDao {

	/**
	 * 根据角色ID查找权限
	 * @param roleId
	 * @return
	 */
	public List<Permission> findPsermissionsByRoleId(String roleId) {
		Connection connection = null;
		List<Permission> permissions = new ArrayList<Permission>();
		try {
			connection = DBUtil.getConnection();
			String sql="select pst.id,pst.url,pst.name ,pst.create_time,pst.isdelete"
					+ " from permission_shiro_teemo pst,role_permission_teemo rpt "
					+ " where rpt.role_id=? and rpt.per_id=pst.id and pst.isdelete='0'";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, roleId);
			ResultSet rSet = ps.executeQuery();
			while(rSet.next()){
				String id = rSet.getString("id");
				String url = rSet.getString("url");
				String name = rSet.getString("name");
				String create_time = DateUtil.parseDateToString(rSet.getTime("create_time"));
				String isdelete = rSet.getString("isdelete");
				Permission permission = new Permission(id, url, name);
				permission.setCreate_time(create_time);
				permission.setIsDelete(isdelete);
				permissions.add(permission);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
		return permissions;
	}

	/**
	 * 根据用户ID查找角色
	 * @param userId
	 * @return
	 */
	public List<Role> findRolesByUserId(String userId) {
		Connection connection = null;
		List<Role> roles = new ArrayList<Role>();
		try {
			connection = DBUtil.getConnection();
			String sql="select rst.id,rst.rolename,rst.roleType,"
					+ "	rst.create_time,rst.delete_tiem,"
					+ "	rst.last_update_time,rst.isdelete"
					+ " from user_role_teemo urt ,role_shiro_teemo rst"
					+ "	where urt.user_id=? and urt.role_id=rst.id and isdelete='0'";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rSet = ps.executeQuery();
			while(rSet.next()){
				String id = rSet.getString("id");
				String roleName = rSet.getString("rolename");
				String roleType = rSet.getString("roleType");
				String isdelete = rSet.getString("isdelete");
				String create_time = DateUtil.parseDateToString(rSet.getTime("create_time"));
				List<Permission> permissions = new ArrayList<Permission>();
				Role role = new Role(id, roleName, roleType, permissions);
				role.setCreate_time(create_time);
				role.setIsDelete(isdelete);
				roles.add(role);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
		return roles;
	}

	/**
	 * 根据用户id查找用户的权限
	 * @param userId
	 * @return
	 */
	public List<Permission> getPermisssionsByUserId(String userId){
		try {
			List<Role> roles = this.findRolesByUserId(userId);
			List<Permission> pers = new ArrayList<Permission>();
			for (Role role : roles) {
				List<Permission> permissions = this.findPsermissionsByRoleId(role.getId());
				pers.addAll(permissions);
			}
			return pers;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}
	
	
	@Test
	public void test1(){
		BaseDaoImp daoImp = new BaseDaoImp();
		List<Permission> list = daoImp.findPsermissionsByRoleId("123456789");
		for (Permission permission : list) {
			System.out.println(permission);
		}
	}
	@Test
	public void test2(){
		BaseDaoImp daoImp = new BaseDaoImp();
		List<Role> list = daoImp.findRolesByUserId("123456789");
		for (Role role : list) {
			List<Permission> pers = daoImp.findPsermissionsByRoleId(role.getId());
			role.setPermissions(pers);
			System.out.println(role);
		}
	}
	@Test
	public void test3(){
		BaseDaoImp daoImp = new BaseDaoImp();
		List<Permission> pers = daoImp.getPermisssionsByUserId("12345678910");
		for (Permission permission : pers) {
			System.out.println(permission);
		}
	}
}

package dao.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import org.junit.Test;

import dao.RoleDao;
import entity.Permission;
import entity.Role;
import util.DBUtil;
import util.DateUtil;

public class RoleDaoImp implements RoleDao {

	public void saveRole(Role role) {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql="insert into role_shiro_teemo(id,rolename,roleType)"+
						"values(?,?,?)";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, role.getId());
			ps.setString(2, role.getRoleName());
			ps.setString(3, role.getRoleType());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
	}

	public void updateRole(Role role) {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql="update role_shiro_teemo set rolename=?,roleType=? "+
						" where  id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, role.getRoleName());
			ps.setString(2, role.getRoleType());
			ps.setString(3, role.getId());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
		
	}
	public void deleteRoleById(String id) {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql="delete from role_shiro_teemo where id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}

	}

	public Role findRoleById(String roleid) {
		Connection connection = null;
		Role role = null;
		try {
			connection = DBUtil.getConnection();
			String sql="select rst.id,rst.rolename,rst.roleType,"
					+ "	rst.create_time,rst.delete_tiem,"
					+ "	rst.last_update_time,rst.isdelete"
					+ " from role_shiro_teemo rst"
					+ "	where isdelete='0' and rst.id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, roleid);
			ResultSet rSet = ps.executeQuery();
			while(rSet.next()){
				String id = rSet.getString("id");
				String roleName = rSet.getString("rolename");
				String roleType = rSet.getString("roleType");
				String isdelete = rSet.getString("isdelete");
				String create_time = DateUtil.parseDateToString(rSet.getTime("create_time"));
				List<Permission> permissions = new BaseDaoImp().findPsermissionsByRoleId(id);
				role = new Role(id, roleName, roleType, permissions);
				role.setCreate_time(create_time);
				role.setIsDelete(isdelete);
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
		return role;
	}
	
	public int getSize() {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql = "select count(*) totals from role_shiro_teemo";
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet set = ps.executeQuery();
			if(set.next()){
				return Integer.parseInt(set.getString("totals"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.closeConnection(connection);
		}
		return 0;
	}

	public List<Role> findAll(int page,int rows,String sname) {
		Connection connection = null;
		List<Role> roles = new ArrayList<Role>();
		try {
			connection = DBUtil.getConnection();

			String sql="select rst.id,rst.rolename,rst.roleType,"
					+ "	rst.create_time,rst.delete_tiem,"
					+ "	rst.last_update_time,rst.isdelete"
					+ " from role_shiro_teemo rst"
					+ "	where isdelete='0'and (rst.rolename like ? or rst.roleType like ?) order by create_time desc";
			sql =" select t2.* from ( "+
					"select t1.*,rownum rn from "+ 
					" ("+sql+") t1 "+
					") t2 "+
					"where t2.rn between ? and ?";
			connection = DBUtil.getConnection();
			PreparedStatement ps = connection.prepareStatement(sql);
			if(sname==null){
				sname="";
			}
			ps.setString(1, "%"+sname+"%");
			ps.setString(2, "%"+sname+"%");
			int begin = (page-1)*rows +1;
			int end = page*rows;
			ps.setInt(3, begin);
			ps.setInt(4, end);
			
			ResultSet rSet = ps.executeQuery();
			while(rSet.next()){
				String id = rSet.getString("id");
				String roleName = rSet.getString("rolename");
				String roleType = rSet.getString("roleType");
				String isdelete = rSet.getString("isdelete");
				String create_time = DateUtil.parseDateToString(rSet.getTime("create_time"));
				List<Permission> permissions = new BaseDaoImp().findPsermissionsByRoleId(id);
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

	public List<Role> findRolesByNameOrByType(String nameOrType) {
		// TODO Auto-generated method stub
		return null;
	}
	@Test
	public void test1(){
		RoleDao dao = new RoleDaoImp();
		System.out.println(dao.findRoleById("123456789"));
		
	}

	/**
	 * 根据角色id修改角色对应的权限
	 */
	public void updateRolePermission(String roleId, String[] perids) {
		//先将原来的权限清空
		deletePermissionRoleById(roleId);
		//再插入新的权限
		Connection connection = null;
		try {
			
			connection = DBUtil.getConnection();
			String sql="insert into role_permission_teemo(role_id,per_id)"+
						"values(?,?)";
			PreparedStatement ps = connection.prepareStatement(sql);
			for (int i = 0; i < perids.length; i++) {
				ps.setString(1, roleId);
				ps.setString(2, perids[i]);
				ps.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
	}
	public void deletePermissionRoleById(String id) {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql="delete from role_permission_teemo where role_id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}

	}
	
}

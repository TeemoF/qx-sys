package dao.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import dao.UserDao;
import entity.Permission;
import entity.Role;
import entity.User;
import util.DBUtil;
import util.DateUtil;

public class UserDaoImp implements UserDao {

	public void saveUser(User role) {
		// TODO Auto-generated method stub

	}

	public void deleteUserById(String id) {
		// TODO Auto-generated method stub

	}

	public User findUserById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getSize() {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql = "select count(*) totals from user_shiro_teemo";
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
	
	public List<User> findAllUsers(int page,int rows,String info) {
		Connection connection = null;
		List<User> list = new ArrayList<User>();
		User user = null;
		try{
			
			String sql="select id,nickname,realname,password,email,status ,isdelete,create_time"
					+ " from user_shiro_teemo "
					+ "where isdelete='0' and (nickname like ? or email like ?) order by create_time desc";
			sql =" select t2.* from ( "+
					"select t1.*,rownum rn from "+ 
					" ("+sql+") t1 "+
					") t2 "+
					"where t2.rn between ? and ?";
			connection = DBUtil.getConnection();
			PreparedStatement ps = connection.prepareStatement(sql);
			
			if(info==null){
				info="";
			}
			ps.setString(1, "%"+info+"%");
			ps.setString(2, "%"+info+"%");
			int begin = (page-1)*rows +1;
			int end = page*rows;
			ps.setInt(3, begin);
			ps.setInt(4, end);
			
			ResultSet set = ps.executeQuery();
			while(set.next()){
				String id = set.getString("id");
				String nickname = set.getString("nickname");
				String realname = set.getString("realname");
				String password = set.getString("password");
				String email = set.getString("email");
				String status = set.getString("status");
				String isdelete = set.getString("isdelete");
				String create_time = DateUtil.parseDateToString(set.getTime("create_time"));
				List<Role> roles = new BaseDaoImp().findRolesByUserId(id);
				List<Permission> pers = new BaseDaoImp().getPermisssionsByUserId(id);
				user = new User(id, nickname, realname, password, email, status);
				user.setIsDelete(isdelete);
				user.setCreate_time(create_time);
				user.setRoles(roles);
				user.setPermissions(pers);
				list.add(user);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException();
		}finally{
			DBUtil.closeConnection(connection);
		}
		return list;
	}

	public List<User> findUserByNickameOrByAccount(String nickNameOrEmail) {
		// TODO Auto-generated method stub
		return null;
	}

	public User login(String userName, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	public User findUserByUsername(String userName) {
		User user=null;
		Connection connection = null;
		try {
			String sql="select id,nickname,realname,password,email,status ,isdelete,create_time"
					+ " from user_shiro_teemo "
					+ "where isdelete='0' and nickname=?";
			connection = DBUtil.getConnection();
			PreparedStatement pstmt=connection.prepareStatement(sql);
			pstmt.setString(1, userName);
			ResultSet set=pstmt.executeQuery();
			if(set.next()){
				String id = set.getString("id");
				String nickname = set.getString("nickname");
				String realname = set.getString("realname");
				String password = set.getString("password");
				String email = set.getString("email");
				String status = set.getString("status");
				String isdelete = set.getString("isdelete");
				String create_time = DateUtil.parseDateToString(set.getTime("create_time"));
				List<Role> roles = new BaseDaoImp().findRolesByUserId(id);
				List<Permission> pers = new BaseDaoImp().getPermisssionsByUserId(id);
				user = new User(id, nickname, realname, password, email, status);
				user.setIsDelete(isdelete);
				user.setCreate_time(create_time);
				user.setRoles(roles);
				user.setPermissions(pers);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUtil.closeConnection(connection);
		}
		return user;
		
	}

	/*@Test
	public void test1(){
		UserDaoImp dao = new UserDaoImp();
		List<User> list = dao.findAllUsers();
		for (User user : list) {
			System.out.println(user);
		}
	}*/

	/**
	 * 根据用户id修改用户对应的角色
	 */
	public void updateUserRoleById(String userId, String[] roleIds) {
		//先将原来的权限清空
		deleteUseRoleById(userId);
		//再插入新的权限
		Connection connection = null;
		try {
			
			connection = DBUtil.getConnection();
			String sql="insert into user_role_teemo(user_id,role_id)"+
						"values(?,?)";
			PreparedStatement ps = connection.prepareStatement(sql);
			for (int i = 0; i < roleIds.length; i++) {
				ps.setString(1, userId);
				ps.setString(2, roleIds[i]);
				ps.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
		
	}
	
	/**
	 * 修改用户的角色的时候，先将原来的角色清空
	 * @param id
	 */
	public void deleteUseRoleById(String id) {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql="delete from user_role_teemo where user_id=?";
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

	public List<Role> findRoles() {
		Connection connection = null;
		List<Role> roles = new ArrayList<Role>();
		try {
			connection = DBUtil.getConnection();
			String sql="select rst.id,rst.rolename,rst.roleType,"
					+ "	rst.create_time,rst.delete_tiem,"
					+ "	rst.last_update_time,rst.isdelete"
					+ " from role_shiro_teemo rst"
					+ "	where isdelete='0'";
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rSet = ps.executeQuery();
			while(rSet.next()){
				String id = rSet.getString("id");
				String roleName = rSet.getString("rolename");
				String roleType = rSet.getString("roleType");
				String isdelete = rSet.getString("isdelete");
				Role role = new Role(id, roleName, roleType, null);
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
}

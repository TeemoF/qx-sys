package dao.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import dao.PermissionDao;
import entity.Permission;
import util.DBUtil;
import util.DateUtil;

public class PermissionImp implements PermissionDao {

	public void savePermission(Permission permission) {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql="insert into permission_shiro_teemo(id,url,name) values(?,?,?)";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, permission.getId());
			ps.setString(2, permission.getUrl());
			ps.setString(3, permission.getName());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}

	}

	public void deletePermissionById(String id) {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql="delete from permission_shiro_teemo where id=?";
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

	public Permission findPermissionById(String id) {
		Connection connection = null;
		Permission permission = null;
		try {
			connection = DBUtil.getConnection();
			String sql="select pst.id,pst.url,pst.name ,pst.create_time,pst.isdelete"
					+ " from permission_shiro_teemo  pst"
					+ " where pst.isdelete='0' and pst.id=? ";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rSet = ps.executeQuery();
			while(rSet.next()){
				String url = rSet.getString("url");
				String name = rSet.getString("name");
				String create_time = DateUtil.parseDateToString(rSet.getTime("create_time"));
				String isdelete = rSet.getString("isdelete");
				permission = new Permission(id, url, name);
				permission.setCreate_time(create_time);
				permission.setIsDelete(isdelete);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
		return permission;
	}

	public int getSize() {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql = "select count(*) totals from permission_shiro_teemo";
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
	
	public List<Permission> findAll(int page,int rows,String info) {
		Connection connection = null;
		List<Permission> permissions = new ArrayList<Permission>();
		try {
			connection = DBUtil.getConnection();
			String sql="select pst.id,pst.url,pst.name ,pst.create_time,pst.isdelete"
					+ " from permission_shiro_teemo  pst"
					+ " where pst.isdelete='0' and pst.name like ? order by create_time desc";
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
			int begin = (page-1)*rows +1;
			int end = page*rows;
			ps.setInt(2, begin);
			ps.setInt(3, end);
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

	public List<Permission> findAll() {
		Connection connection = null;
		List<Permission> permissions = new ArrayList<Permission>();
		try {
			connection = DBUtil.getConnection();
			String sql="select pst.id,pst.url,pst.name ,pst.create_time,pst.isdelete"
					+ " from permission_shiro_teemo  pst"
					+ " where pst.isdelete='0' order by create_time desc";
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rSet = ps.executeQuery();
			while(rSet.next()){
				String id = rSet.getString("id");
				String url = rSet.getString("url");
				String name = rSet.getString("name");
				String isdelete = rSet.getString("isdelete");
				Permission permission = new Permission(id, url, name);
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

	public List<Permission> findPermissionByName(String permissionName) {
		return null;
	}
	public void updatePermission(Permission permission) {
		Connection connection = null;
		try {
			connection = DBUtil.getConnection();
			String sql="update permission_shiro_teemo set url=?,name=? "+
						" where  id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, permission.getUrl());
			ps.setString(2, permission.getName());
			ps.setString(3, permission.getId());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		} finally{
			DBUtil.closeConnection(connection);
		}
	}
		
	
	/*@Test
	public void test1(){
		PermissionImp dao = new PermissionImp();
		List<Permission> permissions = dao.findAll();
		for (Permission permission : permissions) {
			System.out.println(permission);
		}
	}*/
}

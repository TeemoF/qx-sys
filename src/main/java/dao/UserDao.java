package dao;

import java.util.List;

import entity.Role;
import entity.User;

public interface UserDao{
	public void saveUser(User role);
	public void deleteUserById(String id);
	public User findUserById(String id);
	public List<User> findAllUsers(int page,int rows,String info);
	public List<User> findUserByNickameOrByAccount(String nickNameOrEmail);
	public User login(String userName,String password);
	public User findUserByUsername(String userName);
	public void updateUserRoleById(String userId,String[] roleIds);
	public List<Role> findRoles();
	public int getSize();
}

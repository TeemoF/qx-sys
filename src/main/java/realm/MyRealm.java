package realm;

import java.sql.Connection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import dao.UserDao;
import dao.imp.UserDaoImp;
import entity.Permission;
import entity.Role;
import entity.User;


public class MyRealm extends AuthorizingRealm{

	private UserDao userDao=new UserDaoImp();
	
	/**
	 * 为当前登录的用户授予角色和权限
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		/*System.out.println("====================");
		System.out.println(principals.getPrimaryPrincipal());
		System.out.println("=========================");*/
		String username = (String)principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo authorizationInfo=new SimpleAuthorizationInfo();
		try{
			UserDao userDao=new UserDaoImp();
			User user=userDao.findUserByUsername(username);
			//角色
			List<Role> rolesList = user.getRoles();
			Set<String> rolesSet = new HashSet<String>();
			for(Role role:rolesList){
				rolesSet.add(role.getRoleName());
			}
			authorizationInfo.setRoles(rolesSet);
			System.out.println("roles:"+rolesSet);
			//权限
			List<Permission>  persList= user.getPermissions();
			Set<String> persSet = new HashSet<String>();
			for(Permission per:persList){
				persSet.add(per.getName());
			}
			System.out.println("perlist:"+persSet);
			authorizationInfo.setStringPermissions(persSet);
		}catch(Exception e){
			e.printStackTrace();
		}
		return authorizationInfo;
	}

	/**
	 * 验证当前登录的用户
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String userName=(String)token.getPrincipal();
		try{
			User user=userDao.findUserByUsername(userName);
			System.out.println(user);
			if(user!=null){
				AuthenticationInfo authcInfo=new SimpleAuthenticationInfo(user.getNickname(),user.getPassword(),this.getClass().toString());
				return authcInfo;
			}else{
				return null;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

}

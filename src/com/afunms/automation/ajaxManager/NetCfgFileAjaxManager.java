package com.afunms.automation.ajaxManager;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.afunms.automation.dao.CompGroupRuleDao;
import com.afunms.automation.dao.CompStrategyDao;
import com.afunms.automation.dao.NetCfgFileNodeDao;
import com.afunms.automation.model.CompGroupRule;
import com.afunms.automation.model.CompStrategy;
import com.afunms.automation.model.NetCfgFileNode;
import com.afunms.automation.telnet.BaseTelnet;
import com.afunms.automation.util.ReaderFileLine;
import com.afunms.common.base.AjaxBaseManager;
import com.afunms.common.base.AjaxManagerInterface;
import com.afunms.common.util.SessionConstant;
import com.afunms.common.util.SysLogger;
import com.afunms.initialize.ResourceCenter;
import com.afunms.polling.ssh.SSHUtil;
import com.afunms.system.model.User;

public class NetCfgFileAjaxManager extends AjaxBaseManager implements AjaxManagerInterface {
	/**
	 * 
	 * @description ajax验证远程登录
	 * @author wangxiangyong
	 * @date Mar 12, 2013 9:25:11 AM
	 * @return void
	 */
	public void verifyLogin() {

		int connecttype = getParaIntValue("connecttype");
		String username = getParaValue("username");
		String pwd = getParaValue("pwd");
		String supassword = getParaValue("supassword");
		String ipAddress = getParaValue("ipaddress");
		String type = getParaValue("type");
		int port = getParaIntValue("port");
		String suuser=getParaValue("suuser");
//		if(isSuper==null)isSuper="0";
		this.verifyUser(connecttype, username, pwd, suuser, supassword, ipAddress, type, port);

	}

	public void verifyUser(int connecttype, String username, String pwd, String suuser, String supassword, String ipAddress, String type, int port) {
		String result = "验证失败！";
		if (connecttype == 1) {
			boolean flag = false;
			boolean suFlag = true;
			SSHUtil ssh = new SSHUtil(ipAddress, port, username, pwd);
			try {

				flag = ssh.testLogin();
				if (flag && supassword != null && !supassword.equalsIgnoreCase("null") && !supassword.equals("")) {
					String[] commStr = { suuser, supassword };
					String temp = ssh.executeCmds(commStr);
					if (type.equals("h3c")) {
						if (temp.indexOf("Password:") > -1)
							suFlag = false;
					} else {
						if (temp.indexOf("#") > -1)
							suFlag = true;
					}

				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				ssh.disconnect();
			}

			if (flag)
				result = "验证成功！";
			if (!suFlag)
				result = "超级管理员未验证成功！";
		} else if (connecttype == 0) {
//			if (type.equals("cisco")) {// cisco
//				BaseTelnet telnet = new BaseTelnet(ipAddress, username, pwd, port, suuser, supassword);
//				if (telnet.tologin()) {
//					result = "验证成功！";
//				} 
//			} else {
				BaseTelnet tvpn = null;
				try {
					tvpn = new BaseTelnet(ipAddress, username, pwd, port, suuser, supassword);
					result = tvpn.login();
				} catch (Exception e) {
					SysLogger.error("NetworkDeviceAjaxManager.verifyLogin", e);
				} finally {
					if (tvpn != null)
						tvpn.disconnect();
				}

//			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		JSONObject json = JSONObject.fromObject(map);
		out.print(json);
		out.flush();
	}
	/**
	 * 
	 * @description 文件内容比对
	 * @author wangxiangyong
	 * @date Aug 28, 2014 10:44:42 AM
	 * @return void
	 */
	public void compare() {
		String basePath=(String)session.getAttribute("baseCfgName");
		String comparePath=(String)session.getAttribute("compareCfgName");
		String pri=ResourceCenter.getInstance().getSysPath().replace("\\", "/")+ "cfg/" ;
		File file1=new File(pri+basePath);
		File file2=new File(pri+comparePath);
		Object[] results = null;
		try {
			results = ReaderFileLine.diffText(file2, file1);
		} catch (Exception e) {
			e.printStackTrace();
		}
			JSONObject obj = new JSONObject();
			JSONArray array = new JSONArray();
			{
				JSONObject basic = new JSONObject();
				basic.put("basic", results[1]);
				array.add(basic);
				
				JSONObject diff = new JSONObject();
				diff.put("diff", results[0]);
				array.add(diff);
			}
			obj.put("records",array);
		out.print(obj);
		out.flush();
	}
	/**
	 * 
	 * @description 加载配置文件内容
	 * @author wangxiangyong
	 * @date Aug 30, 2014 2:40:45 PM
	 * @return void
	 */
	public void loadFile() {
		String filePath = (String) getParaValue("filePath");
		String prePath = ResourceCenter.getInstance().getSysPath();
		FileReader fr = null;
		try {
			fr = new FileReader(prePath + filePath);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		BufferedReader br = new BufferedReader(fr);
		String lineStr = "";
		StringBuffer content = new StringBuffer();
		try {
			while (null != (lineStr = br.readLine())) {
				content.append(lineStr + "\r\n");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("value", content.toString());
		JSONObject json = JSONObject.fromObject(map);
		out.print(json);
		out.flush();

	}
	/**
	 * 
	 * @description 验证登陆
	 * @author wangxiangyong
	 * @date Apr 23, 2013 11:02:44 AM
	 * @return void
	 */
	public void verifyUpdate() {
		String id = getParaValue("id");
		NetCfgFileNodeDao telnetcfgdao = null;
		NetCfgFileNode hmo = null;
		try {
			telnetcfgdao = new NetCfgFileNodeDao();
			hmo = (NetCfgFileNode) telnetcfgdao.findByID(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			telnetcfgdao.close();
		}
		if(hmo!=null){
		int connecttype = hmo.getConnecttype();
		String username =hmo.getUser();
		String pwd = hmo.getPassword();
		String suuser =hmo.getSuuser();
		String supassword = hmo.getSupassword();
		String ipAddress = hmo.getIpaddress();
//		String promtp =hmo.getDefaultpromtp();
		String type =hmo.getDeviceRender();
		int port =hmo.getPort();

		this.verifyUser(connecttype, username, pwd, suuser, supassword, ipAddress, type, port);
		}
	}
	private void showFileContent() {
		String contain = getParaValue("contain");
		String command = getParaValue("command");
		String content = getParaValue("cmdContent");
		StringBuffer sb = new StringBuffer();
		String[] contains = new String[contain.split(",").length];
		contains = contain.split(",");
		String[] commands = new String[command.split(",").length];
		commands = command.split(",");
		if (contains != null && commands != null && contains.length == commands.length) {
			for (int i = 0; i < commands.length; i++) {
				if (contains[i].equals("1")) {
					String beginStr = "*****************begin(" + commands[i] + ")*****************\r\n";
					String endStr = "*****************end(" + commands[i] + ")*****************\r\n";
					int begin = content.indexOf(beginStr);
					int end = content.indexOf(endStr);
					sb.append(content.substring(begin, end + endStr.length()));
				}

			}

		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("content", sb.toString());
		JSONObject json = JSONObject.fromObject(map);
		out.print(json);
		out.flush();
	}
	private void showContent() {
		String command = this.getParaValue("command");
		String content = this.getParaValue("cmdContent");
		String beginStr = "*****************begin(" + command.trim() + ")*****************\r\n";
		String endStr = "*****************end(" + command.trim() + ")*****************";
		int begin = content.indexOf(beginStr);
		int end = content.indexOf(endStr);
		content = content.substring(begin + beginStr.length(), end);
		Map<String, String> map = new HashMap<String, String>();

		map.put("content", content);
		JSONObject json = JSONObject.fromObject(map);
		out.print(json);
		out.flush();
	}
	//修改工作组
	public void updateGroupRule(){
	    int id=getParaIntValue("id");
		String name=getParaValue("name");
		String desciption=getParaValue("description");
		String ids=getParaValue("checkbox");
		
		try {
			name=new String(name.getBytes("iso8859-1"), "UTF-8");
			desciption=new String(desciption.getBytes("iso8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		User user = (User) session.getAttribute(SessionConstant.CURRENT_USER);
		CompGroupRule vo=new CompGroupRule();
		vo.setId(id);
		vo.setName(name);
		
		vo.setDescription(desciption);
		vo.setRuleId(ids);
		vo.setLastModifiedBy(user.getName());
		vo.setLastModifiedTime(sdf.format(date));
		CompGroupRuleDao dao=new CompGroupRuleDao();
		boolean isSucess=dao.update(vo);
	Map<String, Boolean> map = new HashMap<String, Boolean>();
	map.put("result", isSucess);
	JSONObject json = JSONObject.fromObject(map);
	out.print(json);
	out.flush();
	}
	//保存修改策略
	public void updateStrategy(){
		int id=getParaIntValue("id");
		String name=getParaValue("name");
		String description=getParaValue("description");
		int type=getParaIntValue("type");
		int violateType=getParaIntValue("violateType");
		String ids=getParaValue("checkbox");
		try {
			name=new String(name.getBytes("iso8859-1"), "UTF-8");
			description=new String(description.getBytes("iso8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		User user = (User) session.getAttribute(SessionConstant.CURRENT_USER);
		CompStrategy vo=new CompStrategy();
		vo.setId(id);
		vo.setName(name);
		vo.setDescription(description);
		vo.setType(type);
		vo.setViolateType(violateType);
		vo.setGroupId(ids.toString());
		vo.setLastModifiedBy(user.getName());
		vo.setLastModifiedTime(sdf.format(date));
		CompStrategyDao dao=new CompStrategyDao();
		boolean isSuccess=dao.update(vo);	
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", isSuccess);
		JSONObject json = JSONObject.fromObject(map);
		out.print(json);
		out.flush();
	}
	public void execute(String action) {
		if (action.equals("verifyLogin")) {
			verifyLogin();
		}
		if (action.equals("compare")) {
			compare();
		}
		if (action.equals("loadFile")) {
			loadFile();
		}
		if (action.equals("verifyUpdate")) {//verifyUpdate
			verifyUpdate();
		}
		if (action.equals("showFileContent")) {//verifyUpdate
			showFileContent();
		}
		if (action.equals("showContent")) {//verifyUpdate
			showContent();
		}
		if (action.equals("updateGroupRule")) {//修改规则组
			updateGroupRule();
		}
		if (action.equals("updateStrategy")) {//修改策略
			updateStrategy();
		}
		
	}

}

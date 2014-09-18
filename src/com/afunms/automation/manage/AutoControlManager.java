package com.afunms.automation.manage;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.afunms.automation.dao.CmdCfgDao;
import com.afunms.automation.dao.CmdCfgFileDao;
import com.afunms.automation.dao.NetCfgFileNodeDao;
import com.afunms.automation.dao.TimingBackupCfgFileDao;
import com.afunms.automation.dao.TimingBackupConditionDao;
import com.afunms.automation.model.CmdCfg;
import com.afunms.automation.model.CmdCfgFile;
import com.afunms.automation.model.CmdResult;
import com.afunms.automation.model.NetCfgFileNode;
import com.afunms.automation.model.TimingBackupCfgFile;
import com.afunms.automation.model.TimingBackupCondition;
import com.afunms.automation.telnet.CiscoTelnet;
import com.afunms.automation.telnet.NetTelnetUtil;
import com.afunms.automation.telnet.RedGiantTelnet;
import com.afunms.automation.telnet.ZteTelnet;
import com.afunms.capreport.common.DateTime;
import com.afunms.common.base.BaseManager;
import com.afunms.common.base.ManagerInterface;
import com.afunms.common.util.GeneratorKey;
import com.afunms.common.util.SessionConstant;
import com.afunms.common.util.SysLogger;
import com.afunms.initialize.ResourceCenter;
import com.afunms.polling.ssh.SSHUtil;
import com.afunms.system.model.User;
/**
 * 
 * @descrition TODO
 * @author wangxiangyong
 * @date Aug 29, 2014 3:24:57 PM
 */
public class AutoControlManager extends BaseManager implements ManagerInterface {
	/**
	 * 
	 * @description ×ªÏò¶¨Ê±É¨ÃèÈÕÖ¾ÁÐ±í
	 * @author wangxiangyong
	 * @date Aug 30, 2014 10:37:32 AM
	 * @return String  
	 * @return
	 */
	private String inspectionList() {
		TimingBackupCfgFileDao timingBackupTelnetConfigDao = new TimingBackupCfgFileDao();
		List<TimingBackupCfgFile> timingBackupTelnetConfigList = null;
		try {
			timingBackupTelnetConfigList = timingBackupTelnetConfigDao.getAllList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			timingBackupTelnetConfigDao.close();
		}
		request.setAttribute("timingBackupTelnetConfigList", timingBackupTelnetConfigList);
		return "/automation/controller/inspectionList.jsp";
	}
	/**
	 * 
	 * @description Ôö¼Ó¶¨Ê±±¸·ÝÅäÖÃÎÄ¼þµÄÈÎÎñ
	 * @author wangxiangyong
	 * @date Aug 29, 2014 3:33:09 PM
	 * @return String  
	 * @return
	 */
	private String addFileBackup() {
		return "/automation/controller/addFileBackup.jsp";
	}
	/**
	 * 
	 * @description É¾³ý¶¨Ê±ÃüÁîÈÕÖ¾ÎÄ¼þµÄÈÎÎñ
	 * @author wangxiangyong
	 * @date Aug 29, 2014 3:39:28 PM
	 * @return String  
	 * @return
	 */
	private String deleteFileBackup() {
		String[] ids = getParaArrayValue("checkbox");
		if (ids != null) {
			if (ids != null && ids.length != 0) {
				TimingBackupCfgFileDao dao = new TimingBackupCfgFileDao();
				try {
					dao.delete(ids);
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					dao.close();
				}

			}
		}
		return inspectionList();
	}
	/**
	 * 
	 * @description ±à¼­¶¨Ê±ÃüÁîÈÕÖ¾ÎÄ¼þµÄÈÎÎñ
	 * @author wangxiangyong
	 * @date Aug 29, 2014 3:47:34 PM
	 * @return String  
	 * @return
	 */
	private String ready_editFileBackup() {
		String id = getParaValue("id");

		TimingBackupCfgFileDao timingBackupTelnetConfigDao = new TimingBackupCfgFileDao();
		TimingBackupCfgFile timingBackupCfgFile = null;
		try {
			timingBackupCfgFile = (TimingBackupCfgFile) timingBackupTelnetConfigDao.findByID(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			timingBackupTelnetConfigDao.close();
		}

		TimingBackupConditionDao conditionDao = new TimingBackupConditionDao();
		List<TimingBackupCondition> conditionList = conditionDao.findByCondition(" where timingId=" + id);
		conditionDao.close();
		request.setAttribute("conditionList", conditionList);
		request.setAttribute("id", id);
		request.setAttribute("timingBackupCfgFile", timingBackupCfgFile);
		return "/automation/controller/editFileBackup.jsp";
	}
	/**
	 * 
	 * @description Æô¶¯¶¨Ê±±¸·Ý
	 * @author wangxiangyong
	 * @date Aug 29, 2014 3:57:12 PM
	 * @return String  
	 * @return
	 */
	private String onBackup() {
		String id = getParaValue("id");
		List<TimingBackupCfgFile> timingBackupTelnetConfigList = null;
		TimingBackupCfgFileDao timingBackupTelnetConfigDao = new TimingBackupCfgFileDao();
		try {
			timingBackupTelnetConfigDao.updateStatus("1", id);
			timingBackupTelnetConfigList = timingBackupTelnetConfigDao.getAllList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			timingBackupTelnetConfigDao.close();
		}
		request.setAttribute("timingBackupTelnetConfigList", timingBackupTelnetConfigList);
		return "/automation/controller/inspectionList.jsp";
	}
	/**
	 * 
	 * @description È¡Ïû¶¨Ê±±¸·Ý
	 * @author wangxiangyong
	 * @date Aug 29, 2014 3:58:17 PM
	 * @return String  
	 * @return
	 */
	private String disBackup() {
		String id = getParaValue("id");
		List<TimingBackupCfgFile> timingBackupTelnetConfigList = null;
		TimingBackupCfgFileDao timingBackupTelnetConfigDao = new TimingBackupCfgFileDao();
		try {
			timingBackupTelnetConfigDao.updateStatus("0", id);
			timingBackupTelnetConfigList = timingBackupTelnetConfigDao.getAllList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			timingBackupTelnetConfigDao.close();
		}
		request.setAttribute("timingBackupTelnetConfigList", timingBackupTelnetConfigList);
		return "/automation/controller/inspectionList.jsp";
	}
	/**
	 * 
	 * @description ¶¨Ê±ÃüÁîÉ¨Ãè Èë¿â
	 * @author wangxiangyong
	 * @date Aug 29, 2014 4:08:50 PM
	 * @return String  
	 * @return
	 */
	private String saveTimingCmdScan() {
		TimingBackupCfgFileDao timingBackupTelnetConfigDao = new TimingBackupCfgFileDao();
		TimingBackupCfgFile fileBackupTelnetConfig = new TimingBackupCfgFile();
		String ipaddress = getParaValue("ipaddress");
		String[] sendtimemonth = request.getParameterValues("sendtimemonth");
		String[] sendtimeweek = request.getParameterValues("sendtimeweek");
		String[] sendtimeday = request.getParameterValues("sendtimeday");
		String[] sendtimehou = request.getParameterValues("sendtimehou");
		String transmitfrequency = request.getParameter("transmitfrequency");
		String status = getParaValue("status");
		String bkpType = getParaValue("bkpType");
		String content = getParaValue("content");
		List<TimingBackupCfgFile> timingBackupTelnetConfigList = null;
		DateTime dt = new DateTime();
		try {
			fileBackupTelnetConfig.setTelnetconfigids(ipaddress);
			fileBackupTelnetConfig.setBackup_sendfrequency(Integer.parseInt(transmitfrequency));
			fileBackupTelnetConfig.setBackup_time_month(arrayToString(sendtimemonth));
			fileBackupTelnetConfig.setBackup_time_week(arrayToString(sendtimeweek));
			fileBackupTelnetConfig.setBackup_time_day(arrayToString(sendtimeday));
			fileBackupTelnetConfig.setBackup_time_hou(arrayToString(sendtimehou));
			fileBackupTelnetConfig.setBackup_date(Integer.parseInt(dt.getMyDateTime(DateTime.Datetime_Format_14)));
			fileBackupTelnetConfig.setStatus(status);
			fileBackupTelnetConfig.setBkpType(bkpType);
			fileBackupTelnetConfig.setContent(content);

			timingBackupTelnetConfigDao.save(fileBackupTelnetConfig);
			timingBackupTelnetConfigDao = new TimingBackupCfgFileDao();
			timingBackupTelnetConfigList = timingBackupTelnetConfigDao.getFileList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			timingBackupTelnetConfigDao.close();
		}
		saveCondition(0);// ±£´æÌõ¼þ
		request.setAttribute("timingBackupTelnetConfigList", timingBackupTelnetConfigList);
		return "/automation/controller/inspectionList.jsp";
	}
	/**
	 * 
	 * @description ¶¨Ê±ÃüÁîÉ¨Ãè Èë¿â
	 * @author wangxiangyong
	 * @date Aug 29, 2014 4:08:50 PM
	 * @return String  
	 * @return
	 */
	private String modifyTimingCmdScan() {
		TimingBackupCfgFileDao timingBackupTelnetConfigDao = new TimingBackupCfgFileDao();
		TimingBackupCfgFile fileBackupTelnetConfig = new TimingBackupCfgFile();
		String ipaddress = getParaValue("ipaddress");
		String[] sendtimemonth = request.getParameterValues("sendtimemonth");
		String[] sendtimeweek = request.getParameterValues("sendtimeweek");
		String[] sendtimeday = request.getParameterValues("sendtimeday");
		String[] sendtimehou = request.getParameterValues("sendtimehou");
		String transmitfrequency = request.getParameter("transmitfrequency");
		String bkpType = request.getParameter("bkpType");
		String status = getParaValue("status");
		String content = getParaValue("content");
		String id = getParaValue("id");
		List<TimingBackupCfgFile> timingBackupTelnetConfigList = null;
		try {
			fileBackupTelnetConfig.setId(Integer.parseInt(id));
			fileBackupTelnetConfig.setTelnetconfigids(ipaddress);
			fileBackupTelnetConfig.setBackup_sendfrequency(Integer.parseInt(transmitfrequency));
			fileBackupTelnetConfig.setBackup_time_month(arrayToString(sendtimemonth));
			fileBackupTelnetConfig.setBackup_time_week(arrayToString(sendtimeweek));
			fileBackupTelnetConfig.setBackup_time_day(arrayToString(sendtimeday));
			fileBackupTelnetConfig.setBackup_time_hou(arrayToString(sendtimehou));
			fileBackupTelnetConfig.setBkpType(bkpType);
			// timingBackupTelnetConfig.setBackup_date(Integer.parseInt(dt.getMyDateTime(DateTime.Datetime_Format_14)));
			fileBackupTelnetConfig.setStatus(status);
			fileBackupTelnetConfig.setContent(content);
			timingBackupTelnetConfigDao.update(fileBackupTelnetConfig);


		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			timingBackupTelnetConfigDao.close();
		}
		saveCondition(Integer.parseInt(id));
		return inspectionList();
	}
	private void saveCondition(int id) {
		String[] selVals = null;
		String[] textVals = null;
		String selVal = getParaValue("selVal");
		String textVal = getParaValue("textVal");
		TimingBackupConditionDao dao = null;
		try {

			dao = new TimingBackupConditionDao();
			TimingBackupCondition vo = null;
			dao.addBatch(vo, id);
			if (selVal != null && textVal != null) {
				selVals = new String[selVal.split(",").length];
				textVals = new String[textVal.split(",").length];
				selVals = selVal.split(",");
				textVals = textVal.split(",");
				if (selVals.length == textVals.length) {
					int key = 0;
					if (id == 0) {
						key = GeneratorKey.getInstance().getTimingKey();
					} else {
						key = id;
					}

					for (int i = 0; i < selVals.length; i++) {

						vo = new TimingBackupCondition();
						vo.setTimingId(key);
						vo.setIsContain(Integer.parseInt(selVals[i]));
						vo.setContent(textVals[i]);
						dao.addBatch(vo, -2);
					}

				}
			}
			dao.executeBatch();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.close();
		}

	}
	public String arrayToString(String[] array) {
		StringBuilder sb = new StringBuilder();
		if (array != null) {
			for (String value : array) {
				sb.append("/");
				sb.append(value);
			}
			sb.append("/");
		}
		return sb.toString();
	}
	/**
	 * 
	 * @description ¶¨Ê±ÃüÁîÉ¨ÃèÅäÖÃÎÄ¼þ»ã×ÜÁÐ±í
	 * @author wangxiangyong
	 * @date Aug 30, 2014 10:54:50 AM
	 * @return String  
	 * @return
	 */
	public String cmdCfgList() {
		CmdCfgFileDao cmdCfgFileDao = new CmdCfgFileDao();
		List vpnDevicelist = cmdCfgFileDao.getAllcfgList();
		cmdCfgFileDao.close();
		NetCfgFileNodeDao telnetConfDao = new NetCfgFileNodeDao();
		List list=null;
		Map<String,NetCfgFileNode> map=new HashMap<String,NetCfgFileNode>();
		try {
			list=telnetConfDao.loadAll();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			telnetConfDao.close();
		}
		if(list!=null){
			for (int i = 0; i < list.size(); i++) {
				NetCfgFileNode node=(NetCfgFileNode)list.get(i);
				map.put(node.getIpaddress(), node);
			}
		}
		request.setAttribute("list", vpnDevicelist);
		request.setAttribute("map", map);
		return "/automation/controller/cmdCfgList.jsp";
	}
	/**
	 * 
	 * @description ¶¨Ê±ÃüÁîÉ¨ÃèÅäÖÃÎÄ¼þ»ã×ÜÁÐ±í
	 * @author wangxiangyong
	 * @date Aug 30, 2014 10:54:50 AM
	 * @return String  
	 * @return
	 */
	public String queryCmdNodeById() {
		String id=getParaValue("id");
		CmdCfgFileDao cmdCfgFileDao = new CmdCfgFileDao();
		List vpnDevicelist = cmdCfgFileDao.loadById(id);
		cmdCfgFileDao.close();
		NetCfgFileNodeDao telnetConfDao = new NetCfgFileNodeDao();
		List list=null;
		Map<String,NetCfgFileNode> map=new HashMap<String,NetCfgFileNode>();
		try {
			list=telnetConfDao.loadAll();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			telnetConfDao.close();
		}
		if(list!=null){
			for (int i = 0; i < list.size(); i++) {
				NetCfgFileNode node=(NetCfgFileNode)list.get(i);
				map.put(node.getIpaddress(), node);
			}
		}
		request.setAttribute("list", vpnDevicelist);
		request.setAttribute("map", map);
		return "/automation/controller/cmdCfgList.jsp";
	}
	/**
	 * 
	 * @description ¶¨Ê±ÃüÁîÉ¨ÃèÅäÖÃÎÄ¼þÁÐ±í
	 * @author wangxiangyong
	 * @date Aug 30, 2014 11:50:39 AM
	 * @return String  
	 * @return
	 */
	public String cmdCfgDetailList() {
		String ip = getParaValue("ip");
		CmdCfgFileDao vpnFileDao = new CmdCfgFileDao();
		List ipList = vpnFileDao.loadAllIps();
		List vpnDevicelist = vpnFileDao.getcfgListByIp(ip);

		// request.setAttribute("page", 1);

		vpnFileDao.close();
		request.setAttribute("ip", ip);
		request.setAttribute("ipList", ipList);
		request.setAttribute("list", vpnDevicelist);
		return "/automation/controller/cmdCfgDetailList.jsp";
	}
	/**
	 * 
	 * @description É¾³ý¶¨Ê±ÃüÁîÈÕÖ¾ÎÄ¼þ
	 * @author wangxiangyong
	 * @date Aug 30, 2014 11:57:17 AM
	 * @return String  
	 * @return
	 */
	private String deleteLogFile() {
		String[] ids = getParaArrayValue("checkbox");
		if (ids != null) {

			CmdCfgFileDao vpnDao = new CmdCfgFileDao();
			if (ids != null && ids.length != 0) {

				List vpnConfigList = vpnDao.loadByIds(ids);
				for (int j = 0; j < vpnConfigList.size(); j++) {
					CmdCfgFile tmp = (CmdCfgFile) vpnConfigList.get(j);
					if (tmp != null) {
						File f = new File(tmp.getFileName());
						if (f.exists())
							f.delete();
					}
				}

			}
			vpnDao.delete(ids);
			vpnDao.close();

		}
		return cmdCfgDetailList();

	}
	/**
	 * 
	 * @description Ö´ÐÐ½Å±¾ÃüÁî
	 * @author wangxiangyong
	 * @date Aug 30, 2014 12:01:35 PM
	 * @return String  
	 * @return
	 */
	private String deviceCfg() {
		NetCfgFileNodeDao haweitelnetconfDao = new NetCfgFileNodeDao();
		List list = null;
		try {
			list = haweitelnetconfDao.getAllTelnetConfig();
		} catch (RuntimeException e) {
			e.printStackTrace();
		} finally {
			haweitelnetconfDao.close();
		}
		request.setAttribute("list", list);
		return "/automation/controller/exeScript.jsp";
	}
	/**
	 * 
	 * @description TODO
	 * @author wangxiangyong
	 * @date Aug 30, 2014 12:08:08 PM
	 * @return String  
	 * @return
	 */
	private String exeCmd() {
		NetCfgFileNodeDao haweitelnetconfDao = new NetCfgFileNodeDao();
		List deviceList = null;
		try {
			deviceList = haweitelnetconfDao.getAllTelnetConfig();
		} catch (RuntimeException e) {
			e.printStackTrace();
		} finally {
			haweitelnetconfDao.close();
		}
		request.setAttribute("list", deviceList);

		// String ip=getParaValue("netip");
		String[] ips = getParaArrayValue("checkbox");

		String commands = getParaValue("commands");
		String isReturn = getParaValue("isReturn");
		if (isReturn == null)
			isReturn = "0";
		String result = "";
		NetCfgFileNodeDao dao = new NetCfgFileNodeDao();
		NetCfgFileNode vo = null;
		List<NetCfgFileNode> list = new ArrayList<NetCfgFileNode>();
		StringBuffer sBuffer = new StringBuffer();
		List<CmdResult> resultList = new ArrayList<CmdResult>();

		if (ips != null && ips.length > 0) {

			try {
				list = (List) dao.loadByIps(ips);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				dao.close();
			}
			String[] commStr = new String[commands.split("\r\n").length];
			commStr = commands.split("\r\n");

			for (int i = 0; i < list.size(); i++) {
				vo = list.get(i);
				if (vo.getConnecttype() == 1) {
					SSHUtil t = null;
					try {
						t = new SSHUtil(vo.getIpaddress(), vo.getPort(), vo.getUser(), vo.getPassword());
						result = t.executeCmds(commStr);
					} catch (Exception e) {
						SysLogger.error("HaweitelnetconfManager.exeCmd()", e);
					} finally {
						t.disconnect();
					}

				} else {
					if (vo.getDeviceRender().equals("h3c")||vo.getDeviceRender().equals("huawei")) {// h3c
						NetTelnetUtil tvpn = new NetTelnetUtil();
						tvpn.setSuUser(vo.getSuuser());
						tvpn.setSuPassword(vo.getSupassword());// suÃÜÂë
						tvpn.setUser(vo.getUser());// ÓÃ»§
						tvpn.setPassword(vo.getPassword());// ÃÜÂë
						tvpn.setIp(vo.getIpaddress());// ipµØÖ·
//						tvpn.setDEFAULT_PROMPT(vo.getDefaultpromtp());// ½áÊø±ê¼Ç·ûºÅ
						tvpn.setPort(vo.getPort());
						if (isReturn.equals("0")) {
							tvpn.getCommantValue(commStr, resultList, ips[i]);
						} else if (isReturn.equals("1")) {
							result = tvpn.getCommantValue(commStr);
						}
					} else if (vo.getDeviceRender().equals("cisco")) {// cisco
						CiscoTelnet telnet = new CiscoTelnet(vo.getIpaddress(), vo.getUser(), vo.getPassword(), vo.getPort(), vo.getSuuser(), vo.getSupassword());

						if (telnet.tologin()) {
							if (isReturn.equals("0")) {
								telnet.getCommantValue(vo.getSupassword(), commStr, resultList, ips[i]);
							} else if (isReturn.equals("1")) {
								result = telnet.getCommantValue(commStr);
							}
						} else {
							CmdResult cmdResult = new CmdResult();
							cmdResult.setIp(ips[i]);
							cmdResult.setCommand("------");
							cmdResult.setResult("µÇÂ¼Ê§°Ü!");
							resultList.add(cmdResult);
						}

					} else if (vo.getDeviceRender().equals("zte")) {// ÖÐÐËwxy add
						ZteTelnet telnet = new ZteTelnet(vo.getIpaddress(), vo.getUser(), vo.getPassword(), vo.getPort(), vo.getSuuser(), vo.getSupassword());
						if (telnet.tologin()) {
							result = telnet.getCommantValue(commStr);
						}

					} else if (vo.getDeviceRender().equals("redgiant")) {// redgiant

						RedGiantTelnet telnet = new RedGiantTelnet(vo.getIpaddress(), vo.getUser(), vo.getPassword(), vo.getPort(), vo.getSuuser(), vo.getSupassword());
						if (telnet.tologin()) {
							result = telnet.getCommantValue(commStr);
						}
					}

				}
				result = result.replaceAll("  ---- more ----", "").replaceAll("--More--", "").replaceAll("42d", "").replaceAll("                                          ", "").replaceAll("\\\\[", "");

				sBuffer.append(result + "\r\n");
			}
		}

		request.setAttribute("commands", commands);
		request.setAttribute("isReturn", isReturn);
		request.setAttribute("ips", ips);
		request.setAttribute("content", sBuffer.toString());
		request.setAttribute("resultList", resultList);
		return "/automation/controller/netExeScriptLog.jsp";
	}
	/**
	 * 
	 * @description  ¼ÓÔØÃüÁîÎÄ¼þ
	 * @author wangxiangyong
	 * @date Aug 30, 2014 2:26:43 PM
	 * @return String  
	 * @return
	 */
	private String loadFile() {
		CmdCfgDao dao = new CmdCfgDao();
		List list = dao.loadAll();
		request.setAttribute("list", list);
		return "/automation/controller/loadFile.jsp";
	}
/**
 * 
 * @description ±£´æÃüÁîÎÄ¼þ
 * @author wangxiangyong
 * @date Aug 30, 2014 2:26:53 PM
 * @return String  
 * @return
 */
	private String saveFile() {

		String commands = getParaValue("commands");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HH-mm");
		String b_time = sdf.format(new Date());
		String fileName = b_time + ".log";
		request.setAttribute("fileName", fileName);
		request.setAttribute("commands", commands);
		return "/automation/controller/saveFile.jsp";

	}
	private String saveCmdCfg() {
		String fileName = getParaValue("fileName");
		String commands = getParaValue("commands");
		String fileDesc = getParaValue("fileDesc");
		String result = commands.replaceAll(";;", "\r\n");
		String prefix = ResourceCenter.getInstance().getSysPath().replace("\\", "\\\\");
		String filePath = "slascript\\\\" + fileName;
		File f = new File(prefix + filePath);
		try {
			if (!f.exists()) {
				f.createNewFile();
			}
			FileWriter fw = new FileWriter(f);
			fw.write(result);
			fw.flush();
			fw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		User user = (User) session.getAttribute(SessionConstant.CURRENT_USER);
		CmdCfgDao dao = null;
		try {
			dao = new CmdCfgDao();
			CmdCfg vo = new CmdCfg();
			vo.setFilename(filePath);
			vo.setCreateBy(user.getName());
			vo.setCreateTime(sdf.format(date));
			vo.setFileDesc(fileDesc);
			dao.save(vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.close();
		}

		return "/automation/common/status.jsp";
	}
	/**
	 * 
	 * @description ÏÂÔØlogÎÄ¼þ
	 * @author wangxiangyong
	 * @date Aug 30, 2014 3:11:18 PM
	 * @return String  
	 * @return
	 */
	public String downloadLog() {
		String result = getParaValue("content");
		String prefix = ResourceCenter.getInstance().getSysPath().replace("\\", "/");
		String filename = prefix + "cfg\\\\cfgLog.log";
		this.backupLog(filename, result);
		request.setAttribute("filename", filename);
		return "/automation/controller/download.jsp";

	}
	public synchronized void backupLog(String fileName, String result) {
		File f = new File(fileName);
		try {
			if (!f.exists()) {
				f.createNewFile();
			}
			FileWriter fw = new FileWriter(f);
			fw.write(result);
			fw.flush();
			fw.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	/**
	 * ÐÞ¸Ä¶¨Ê±±¸·ÝÈÎÎñ
	 * 
	 * @return
	 */
	private String modifyTimingBackup() {
		TimingBackupCfgFileDao timingBackupTelnetConfigDao = new TimingBackupCfgFileDao();
		TimingBackupCfgFile fileBackupTelnetConfig = new TimingBackupCfgFile();
		String ipaddress = getParaValue("ipaddress");
		String[] sendtimemonth = request.getParameterValues("sendtimemonth");
		String[] sendtimeweek = request.getParameterValues("sendtimeweek");
		String[] sendtimeday = request.getParameterValues("sendtimeday");
		String[] sendtimehou = request.getParameterValues("sendtimehou");
		String transmitfrequency = request.getParameter("transmitfrequency");
		String bkpType = request.getParameter("bkpType");
		String status = getParaValue("status");
		String content = getParaValue("content");
		String id = getParaValue("id");
		List<TimingBackupCfgFile> timingBackupTelnetConfigList = null;
		try {
			fileBackupTelnetConfig.setId(Integer.parseInt(id));
			fileBackupTelnetConfig.setTelnetconfigids(ipaddress);
			fileBackupTelnetConfig.setBackup_sendfrequency(Integer.parseInt(transmitfrequency));
			fileBackupTelnetConfig.setBackup_time_month(arrayToString(sendtimemonth));
			fileBackupTelnetConfig.setBackup_time_week(arrayToString(sendtimeweek));
			fileBackupTelnetConfig.setBackup_time_day(arrayToString(sendtimeday));
			fileBackupTelnetConfig.setBackup_time_hou(arrayToString(sendtimehou));
			fileBackupTelnetConfig.setBkpType(bkpType);
			// timingBackupTelnetConfig.setBackup_date(Integer.parseInt(dt.getMyDateTime(DateTime.Datetime_Format_14)));
			fileBackupTelnetConfig.setStatus(status);
			fileBackupTelnetConfig.setContent(content);
			timingBackupTelnetConfigDao.update(fileBackupTelnetConfig);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			timingBackupTelnetConfigDao.close();
		}
	
		return inspectionList();
	}
	/**
	 * 
	 * @description ¶¨Ê±Ö´ÐÐÒ³ÃæÖÐ£¬µã»÷Ñ¡ÔñÉè±¸£¬Ö´ÐÐ¸Ã·½·¨
	 * @author wangxiangyong
	 * @date Sep 9, 2014 7:26:23 AM
	 * @return String  
	 * @return
	 */
	private String multi_telnet_netip() {
		NetCfgFileNodeDao haweitelnetconfDao = new NetCfgFileNodeDao();
		String deviceType=getParaValue("deviceType");
		StringBuffer whereSql=new StringBuffer();
		if(deviceType!=null&&!deviceType.equals("null")){
			whereSql.append(" where device_render='"+deviceType+"'");
		}
		List list = null;
		try {
			list = haweitelnetconfDao.findByCondition(whereSql.toString());
		} catch (RuntimeException e) {
			e.printStackTrace();
		} finally {
			haweitelnetconfDao.close();
		}
		request.setAttribute("list", list);
		return "/automation/remote/multi_telnet_netip.jsp";
	}
	public String showFileContent() {
		String id = getParaValue("id");
		CmdCfgFileDao dao = new CmdCfgFileDao();
		CmdCfgFile config = (CmdCfgFile) dao.findByID(id);
		FileReader fr = null;
		BufferedReader br = null;
		String lineStr = "";
		StringBuffer sql = null;
		StringBuffer content = new StringBuffer();
		List<String> list = new ArrayList<String>();
		StringBuffer contentStr = new StringBuffer();
		TimingBackupConditionDao conditionDao = new TimingBackupConditionDao();
		List<TimingBackupCondition> conditionList = conditionDao.findByCondition(" where timingId=" + config.getTimingId());
		String path = ResourceCenter.getInstance().getSysPath().replace("\\", "\\\\")+"cfg\\"+config.getFileName();
		File file = new File(path);
		if (file.exists()) {
			try {
				fr = new FileReader(path);
				br = new BufferedReader(fr);
				try {
					while (null != (lineStr = br.readLine())) {
						content.append(lineStr + "\r\n");
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			} catch (FileNotFoundException e1) {
				e1.printStackTrace();
			}

			if (conditionList != null && conditionList.size() > 0) {
				boolean flag = true;
				for (int i = 0; i < conditionList.size(); i++) {
					TimingBackupCondition condition = conditionList.get(i);
					String conStr = condition.getContent();
					if (conStr == null || conStr.trim().equals("")) {
						if (i == (conditionList.size() - 1)) {
							contentStr.append("ÎÞ");
							continue;
						} else {
							continue;
						}
					}
					try {
						fr = new FileReader(config.getFileName());
						br = new BufferedReader(fr);
						try {
							if (condition.getIsContain() == 1) {
								// contentStr.append("°üº¬: ");
								flag = false;
								while (null != (lineStr = br.readLine())) {

									if (lineStr.indexOf(conStr) > -1) {

										contentStr.append("°ü º¬:").append(lineStr).append("\r\n");
										flag = true;
									}
								}
							} else {
								flag = true;
								while (null != (lineStr = br.readLine())) {
									if (lineStr.indexOf(conStr) > -1) {
										flag = false;
										break;
									}
								}
								if (flag) {
									contentStr.append("²»°üº¬:").append(conStr).append("\r\n");
								}
							}

						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					} catch (FileNotFoundException e1) {
						e1.printStackTrace();
					}
				}

			} else {
				contentStr.append("ÎÞ");
			}
		}
		request.setAttribute("content", content.toString());
		request.setAttribute("config", config);
		// request.setAttribute("list", list);
		request.setAttribute("conStr", contentStr.toString());
		return "/automation/controller/showFileContent.jsp";
	}
	public String execute(String action) {
		if (action.equals("inspectionList")) { // ¶¨Ê±É¨ÃèÃüÁîÅäÖÃ
			return inspectionList();
		}
		if (action.equals("addFileBackup")) { // Ôö¼Ó¶¨Ê±±¸·ÝÅäÖÃÎÄ¼þµÄÈÎÎñ
			return addFileBackup();
		}
		if (action.equals("deleteFileBackup")) { // É¾³ý¶¨Ê±ÃüÁîÈÕÖ¾ÎÄ¼þµÄÈÎÎñ
			return deleteFileBackup();
		}
		if (action.equals("ready_editFileBackup")) { // ±à¼­¶¨Ê±ÃüÁîÈÕÖ¾ÎÄ¼þµÄÈÎÎñ
			return ready_editFileBackup();
		}
		if (action.equals("onBackup")) { // Æô¶¯¶¨Ê±±¸·Ý
			return onBackup();
		}
		if (action.equals("disBackup")) { //È¡Ïû¶¨Ê±±¸·Ý
			return disBackup();
		}
		if (action.equals("saveTimingCmdScan")) { //±£´æ¶¨Ê±ÃüÁîÉ¨Ãè Èë¿â
			return saveTimingCmdScan();
		}
		if (action.equals("modifyTimingCmdScan")) { //ÐÞ¸Ä±£´æ¶¨Ê±ÃüÁîÉ¨Ãè Èë¿â
			return modifyTimingCmdScan();
		}
		
		if (action.equals("cmdCfgList")) { //¶¨Ê±ÃüÁîÉ¨ÃèÅäÖÃÎÄ¼þ»ã×ÜÁÐ±í
			return cmdCfgList();
		}
		if (action.equals("cmdCfgDetailList")) { //µ¥¸ö½Úµã¶¨Ê±ÃüÁîÉ¨ÃèÅäÖÃÎÄ¼þ»ã×ÜÁÐ±í
			return cmdCfgDetailList();
		}
		if (action.equals("deviceCfg")) { //Ö´ÐÐ½Å±¾ÃüÁî
			return deviceCfg();
		}
		if (action.equals("exeCmd")) { //Ö´ÐÐ½Å±¾ÃüÁî
			return exeCmd();
		}
		if (action.equals("loadFile")) { //¼ÓÔØÃüÁîÎÄ¼þ
			return loadFile();
		}
		if (action.equals("saveFile")) { //±£´æÃüÁîÎÄ¼þ
			return saveFile();
		}
		if (action.equals("saveCmdCfg")) { //±£´æÃüÁîÎÄ¼þ
			return saveCmdCfg();
		}
		if (action.equals("downloadLog")) { //ÏÂÔØlogÎÄ¼þ
			return downloadLog();
		}
		if (action.equals("modifyTimingBackup")) { //ÐÞ¸Ä¶¨Ê±ÃüÁî½Úµã
			return modifyTimingBackup();
		}
		if (action.equals("multi_telnet_netip")) { //ÏÂÔØlogÎÄ¼þ
			return multi_telnet_netip();
		}
		if (action.equals("queryCmdNodeById")) { //Í¨¹ýID²éÑ¯¶¨Ê±ÃüÁî½Úµã
			return queryCmdNodeById();
		}
		if (action.equals("showFileContent")) { //Õ¹Ê¾logÎÄ¼þÄÚÈÝ
			return showFileContent();
		}
		if (action.equals("deleteLogFile")) { //É¾³ýlogÎÄ¼þ
			return deleteLogFile();
		}
		
		return null;
	}

}

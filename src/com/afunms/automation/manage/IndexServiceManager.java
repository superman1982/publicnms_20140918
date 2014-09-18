package com.afunms.automation.manage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.afunms.alarm.dao.AlarmWayDao;
import com.afunms.alarm.model.AlarmWay;
import com.afunms.automation.dao.CheckResultDao;
import com.afunms.automation.dao.CmdCfgFileDao;
import com.afunms.automation.dao.NetCfgFileNodeDao;
import com.afunms.automation.dao.PasswdTimingConfigDao;
import com.afunms.automation.dao.StrategyIpDao;
import com.afunms.automation.model.CheckResult;
import com.afunms.automation.model.CmdCfgFile;
import com.afunms.automation.model.NetCfgFileNode;
import com.afunms.automation.model.PasswdTimingConfig;
import com.afunms.common.base.BaseManager;
import com.afunms.common.base.ManagerInterface;
import com.afunms.common.util.SessionConstant;
import com.afunms.config.dao.BusinessDao;
import com.afunms.event.dao.EventListDao;
import com.afunms.event.model.EventList;
import com.afunms.system.model.User;
/**
 * 功能： 首页需要展示内容controller 对应视图main.jsp
 * @author Administrator
 *
 */
public class IndexServiceManager extends BaseManager implements ManagerInterface {

	@Override
	public String execute(String action) {
		//密码定时修改列表
		if(action.equals("pwdAlertList")){
			return pwdAlertList();
		}
		if(action.equals("alertList")){
			return alertList();
		}
		if(action.equals("hgxjchzList")){
			return hgxjchzList();
		}
		if(action.equals("dsxjList")){
			return dsxjList();
		}
		
		return null;
	}
	
	/**
	 * 1.密码定时修改列表
	 * @return
	 */
	private String pwdAlertList(){
		PasswdTimingConfigDao passwdTimingBackupTelnetConfigDao = new PasswdTimingConfigDao();
		List<PasswdTimingConfig> passwdTimingBackupTelnetConfigList = null;
		try {
			passwdTimingBackupTelnetConfigList = passwdTimingBackupTelnetConfigDao.getAlList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			passwdTimingBackupTelnetConfigDao.close();
		}

		String nodeid = getParaValue("nodeid");
		String type = getParaValue("type");
		String subtype = getParaValue("subtype");
		String id = getParaValue("id");
		Hashtable<String, String> alarmWayHashtable = new Hashtable<String, String>();

		AlarmWayDao alarmWayDao = new AlarmWayDao();
		try {
			List list = alarmWayDao.loadAll();
			if (list != null) {
				for (int i = 0; i < list.size(); i++) {
					AlarmWay way = (AlarmWay) list.get(i);
					if (way != null) {
						alarmWayHashtable.put(way.getId() + "", way.getName());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			alarmWayDao.close();
		}
		HttpSession session = request.getSession();
		session.setAttribute("alarmWayHashtable", alarmWayHashtable);//密码到期提醒方式
		session.setAttribute("nodeid", nodeid);
		session.setAttribute("type", type);
		session.setAttribute("subtype", subtype);
		session.setAttribute("valTest", "valTest");
		session.setAttribute("pwdAlertList", passwdTimingBackupTelnetConfigList);//需要到时提醒的远程设备集合
		return "/automation/index/pwdAlert.jsp";
	}
	
	/**
	 * 2.告警列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String alertList(){
		EventListDao dao = new EventListDao();
		List<EventList> eventlist =(List<EventList>)dao.loadAll();
		HttpSession session = request.getSession();
		session.setAttribute("eventlist", eventlist);
//		setTarget("/automation/index/alertList.jsp");
        return "/automation/index/alertList.jsp";
	}
	
	/**
	 * 3.合规性检测汇总
	 * @return
	 */
	private String hgxjchzList(){
		CheckResultDao dao=new CheckResultDao();
		List<CheckResult> list=dao.getAllResult();
		request.setAttribute("hgxjchzList", list);
		StrategyIpDao ipDao=new StrategyIpDao();
		List deviceList=ipDao.findByCondition(" where AVAILABILITY=0");
		request.setAttribute("deviceList", deviceList);
		return "/automation/index/hgxhz.jsp";
	}
	
	/**
	 * 4.定时巡检列表
	 * @return
	 */
	private String dsxjList(){
		CmdCfgFileDao ccfDao = new CmdCfgFileDao();
		List<CmdCfgFile> ccfList = new ArrayList<CmdCfgFile>();
		List<String> aliasList = new ArrayList<String>();//巡检的设备对应的设备名称集合
		//巡检的设备集合
		try{
			ccfList =(List<CmdCfgFile>)ccfDao.loadAll(); 
			//巡检的设备对应的名称集合
			for(int i= 0 ;i < ccfList.size();i++){
				aliasList.add(ccfDao.getNameByIp(ccfList.get(i).getIpaddress()));
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("IndexServiceManager...dsxjList...查询远程设备列表失败");
		}
		HttpSession session = request.getSession();
		session.setAttribute("ccfList", ccfList);//设备集合
		session.setAttribute("aliasList", aliasList);//设备名称集合
		return "/automation/index/dsxjlist.jsp";
	}

	//告警列表中方法
	private String getSQL(){
		int status = 99;
		int level1 = 99;
		int bid = 0;

		String subtype = "";
		String b_time = "";
		String t_time = "";
		status = getParaIntValue("status");
		level1 = getParaIntValue("level1");

		if (status == -1)
			status = 99;
		if (level1 == -1)
			level1 = 99;

		session.setAttribute("status", status);
		session.setAttribute("level1", level1);
		bid = getParaIntValue("businessid");
		session.setAttribute("businessid", bid);
		BusinessDao bdao = new BusinessDao();
		List businesslist = bdao.loadAll();
		session.setAttribute("businesslist", businesslist);
		b_time = getParaValue("startdate");
		t_time = getParaValue("todate");
		subtype = getParaValue("subtype");
		if (b_time == null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			b_time = sdf.format(new Date());
		}
		if (t_time == null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			t_time = sdf.format(new Date());
		}
		String starttime1 = b_time + " 00:00:00";
		String totime1 = t_time + " 23:59:59";
		String sql = "";
		try {
			User vo = (User) session.getAttribute(SessionConstant.CURRENT_USER); // 用户姓名
			StringBuffer s = new StringBuffer();
			s.append("where recordtime>= '" + starttime1 + "' "
					+ "and recordtime<='" + totime1 + "'");
			if (!"99".equals(level1 + "")) {
				s.append(" and level1=" + level1);
			}

			if (subtype != null && !"value".equals(subtype)) {
				s.append(" and subtype='" + subtype + "'");
			}
			if (!"99".equals(status + "")) {
				s.append(" and managesign=" + status);
			}
			String businessid = vo.getBusinessids();
			int flag = 0;
			if (bid > 0) {
				s.append(" and businessid like '%," + bid + ",%'");
			}

			sql = s.toString();
			sql = sql + " order by id desc";

		} catch (Exception e) {
			e.printStackTrace();
		}
		HttpSession session = request.getSession();
		session.setAttribute("startdate", b_time);
		session.setAttribute("todate", t_time);
		return sql;
	}
	//告警中的方法
	private String todayList(){
		EventListDao dao = new EventListDao();
		try{
			HttpSession session = request.getSession();
			List list = dao.loadByWhere(getSQL());
			session.setAttribute("alertlist", list);
		}catch(Exception e){
		}finally{
			dao.close();
		}
		return "/alarm/event/todaylist.jsp";
	}
}

package com.afunms.automation.manage;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import com.afunms.common.base.BaseManager;
import com.afunms.common.base.ManagerInterface;
import com.afunms.common.util.SystemConstant;
import com.afunms.event.dao.EventListDao;

public class AlarmManager extends BaseManager implements ManagerInterface {

	@Override
	public String execute(String action) {
		if(action.equals("summary")){
			return summary();
		}
		return null;
	}
	public String summary(){
		String startDate = getParaValue("startdate");
		
		String toDate = getParaValue("todate");
		
		String type = getParaValue("type");
		
		String level = getParaValue("level");
		
		String status = getParaValue("status");
		
		String managesign = getParaValue("managesign");
		if(managesign==null)
		{
			managesign = "0";
		}	
		String ipaddress = getParaValue("ipaddress");
		
		if(ipaddress!=null && ipaddress.trim().length() > 0 ){
		}else {
			ipaddress = "";
		}
		
		request.setAttribute("ipaddress", ipaddress);
		
		StringBuffer whereSB = new StringBuffer();
		
		whereSB.append("where");
		
		whereSB.append(getTimeSql(startDate, toDate));
		
		
			String where = whereSB.toString();
			
			
			List list = null;
			
			EventListDao eventListDao = new EventListDao();
			try {
				int perpage = getPerPagenum();
				int curpage = getCurrentPage();
				list = eventListDao.getSummary(where, curpage, perpage);
				request.setAttribute("page",eventListDao.getPage());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} finally{
				eventListDao.close();
			}
			
			Hashtable hashtable = new Hashtable();
			
			request.setAttribute("list", list);
			request.setAttribute("hashtable", hashtable);
			
			return "/alarm/event/list2.jsp";
		}
	private String getTimeSql(String startDate , String toDate){
		String startTime = getStarttime(startDate);
		
		String toTime = getTotime(toDate);
		
		StringBuffer sbSql = new StringBuffer();
		
		if("mysql".equalsIgnoreCase(SystemConstant.DBType)){
			sbSql.append(" recordtime>'" + startTime +"'");
			sbSql.append(" and recordtime<'" + toTime +"'");
		}else if("oracle".equalsIgnoreCase(SystemConstant.DBType)){
			sbSql.append(" recordtime>to_date('"+startTime+"','YYYY-MM-DD HH24:MI:SS') ");
			sbSql.append(" and recordtime<to_date('"+toTime+"','YYYY-MM-DD HH24:MI:SS')");
		}
		
		
		
		return sbSql.toString();
	}
	public String getTotime(String toDate){
		if(toDate == null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			toDate = sdf.format(new Date());
		}
		String totime = toDate + " 23:59:59";
		
		request.setAttribute("todate", toDate);
		
		return totime;
	}
	public String getStarttime(String startDate){
		if(startDate == null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			startDate = sdf.format(new Date());
		}
		String starttime = startDate + " 00:00:00";
		
		request.setAttribute("startdate", startDate);
		
		return starttime;
	}
}

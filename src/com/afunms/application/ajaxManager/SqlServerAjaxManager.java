package com.afunms.application.ajaxManager;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import net.sf.json.JSONObject;

import com.afunms.application.dao.DBDao;
import com.afunms.application.model.DBVo;
import com.afunms.application.util.IpTranslation;
import com.afunms.common.base.AjaxBaseManager;
import com.afunms.common.base.AjaxManagerInterface;
import com.afunms.common.util.ShareData;
import com.afunms.common.util.SysUtil;
import com.afunms.polling.api.I_HostCollectData;
import com.afunms.polling.impl.HostCollectDataManager;

public class SqlServerAjaxManager extends AjaxBaseManager implements AjaxManagerInterface 
{

	public void execute(String action) 
	{
		// TODO Auto-generated method stub
		if(action.equals("ajaxUpdate_availability"))
		{
			ajaxUpdate_availability();
		}
	}
	private void ajaxUpdate_availability()
	{
		double avgpingcon = 0;
		DBVo vo = new DBVo();
		String id = getParaValue("id");
		DBDao dao = null;
		String bufferCacheHitRatio = null;
		String planCacheHitRatio = null;
		String cursorManagerByTypeHitRatio = null;
		String catalogMetadataHitRatio = null;
		double intBufferCacheHitRatio = 0;
		double intPlanCacheHitRatio = 0;
		double intCursorManagerByTypeHitRatio = 0;
		double intCatalogMetadataHitRatio = 0;
		try{
			dao = new DBDao();
			vo = (DBVo)dao.findByID(id);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(dao != null)
			{
				dao.close();
			}
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String time1 = sdf.format(new Date());					
		String starttime1 = time1 + " 00:00:00";
		String totime1 = time1 + " 23:59:59";
		String newip=SysUtil.doip(vo.getIpAddress());						
		Hashtable ConnectUtilizationhash = new Hashtable();
		I_HostCollectData hostmanager=new HostCollectDataManager();
		try{
			ConnectUtilizationhash = hostmanager.getCategory(vo.getId()+"","SQLPing","ConnectUtilization",starttime1,totime1);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		String pingconavg = "";
		if (ConnectUtilizationhash.get("avgpingcon")!=null)
			pingconavg = (String)ConnectUtilizationhash.get("avgpingcon");
		if(pingconavg != null){
			pingconavg = pingconavg.replace("%", "");
		}
//		Hashtable allsqlserverdata = ShareData.getSqlserverdata();
//		Hashtable ipsqlserverdata = new Hashtable();
//		if(allsqlserverdata != null && allsqlserverdata.size()>0)
//		{
//			if(allsqlserverdata.containsKey(vo.getIpAddress()))
//			{
//				ipsqlserverdata = (Hashtable)allsqlserverdata.get(vo.getIpAddress());
//				Hashtable retValue = (Hashtable)ipsqlserverdata.get("retValue");
//				Hashtable pages = (Hashtable)retValue.get("pages");
//				bufferCacheHitRatio = (String)pages.get("bufferCacheHitRatio");
//				planCacheHitRatio = (String)pages.get("planCacheHitRatio");
//				cursorManagerByTypeHitRatio = (String)pages.get("cursorManagerByTypeHitRatio");
//				catalogMetadataHitRatio = (String)pages.get("catalogMetadataHitRatio");
//				
//				intBufferCacheHitRatio = Double.valueOf(bufferCacheHitRatio);
//				intPlanCacheHitRatio = Double.valueOf(planCacheHitRatio);
//				intCursorManagerByTypeHitRatio = Double.valueOf(cursorManagerByTypeHitRatio);
//				intCatalogMetadataHitRatio = Double.valueOf(catalogMetadataHitRatio);
//			}
//		}
		String ip = vo.getIpAddress();
		try {
			dao = new DBDao();
			IpTranslation tranfer = new IpTranslation();
			String hex = tranfer.formIpToHex(ip);
			String serverip = hex+":"+vo.getAlias();
			Hashtable pages =  dao.getSqlserver_nmspages(serverip);
			bufferCacheHitRatio = (String)pages.get("bufferCacheHitRatio");
			planCacheHitRatio = (String)pages.get("planCacheHitRatio");
			cursorManagerByTypeHitRatio = (String)pages.get("cursorManagerByTypeHitRatio");
			catalogMetadataHitRatio = (String)pages.get("catalogMetadataHitRatio");
			
			intBufferCacheHitRatio = Double.valueOf(bufferCacheHitRatio);
			intPlanCacheHitRatio = Double.valueOf(planCacheHitRatio);
			intCursorManagerByTypeHitRatio = Double.valueOf(cursorManagerByTypeHitRatio);
			intCatalogMetadataHitRatio = Double.valueOf(catalogMetadataHitRatio);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(dao != null){
				dao.close();
			}
		}
		avgpingcon = new Double(pingconavg+"").doubleValue();
		double percent1 = Double.valueOf(avgpingcon);
		double percent2 = 100-percent1;
		Map<String,Double> map = new HashMap<String,Double>();
		map.put("percent1", percent1);
		map.put("percent2", percent2);
		map.put("intBufferCacheHitRatio", intBufferCacheHitRatio);
		map.put("intPlanCacheHitRatio", intPlanCacheHitRatio);
		map.put("intCursorManagerByTypeHitRatio", intCursorManagerByTypeHitRatio);
		map.put("intCatalogMetadataHitRatio", intCatalogMetadataHitRatio);
//		System.out.println("percent1:"+percent1);
//		System.out.println("percent2:"+percent2);
//		System.out.println("intBufferCacheHitRatio:"+intBufferCacheHitRatio);
//		System.out.println("intPlanCacheHitRatio:"+intPlanCacheHitRatio);
//		System.out.println("intCursorManagerByTypeHitRatio:"+intCursorManagerByTypeHitRatio);
//		System.out.println("intCatalogMetadataHitRatio:"+intCatalogMetadataHitRatio);
		JSONObject json = JSONObject.fromObject(map);
		out.print(json);
		out.flush();
	}
	
}

package com.util;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;


/**
 * 
 * 画双线，线的颜色 和轨道线路色号一致
 *
 */
public class ReadThreeLineXmlUtil {
	public static double num=2;//两线之间的距离
	private static FileWriter writer=null;
	public static JSONObject STATIONS=new JSONObject();
	public static int w=1;//线条宽度
	
	
	public static void startDraw() {  
		Map<String,String> mapcor=new HashMap<String,String>();
	  	mapcor.put("1","#ED3229");
	  	mapcor.put("2","#36B854");
	  	mapcor.put("3","#FFD823");
	  	mapcor.put("4","#320176");
	  	mapcor.put("5","#823094");
	  	mapcor.put("6","#CF047A");
	  	mapcor.put("7","#F3560F");
	  	mapcor.put("8","#008CC1");
	  	mapcor.put("9","#91C5DB");
	  	mapcor.put("10","#C7AFD3");
	  	mapcor.put("11","#8C2222");
	  	mapcor.put("12","#007c64");
	  	mapcor.put("13","#f292d1");
	  	mapcor.put("16","#33d4cc");
	  	mapcor.put("17","#C37D75");
	  	mapcor.put("18","#C59652");
	  	mapcor.put("41","#dddddd");
	  	
		
		try {
			File f = new File("C:\\Users\\yb\\Desktop\\CN\\assets\\xml\\stationLineAllSmall.xml");  
			SAXReader reader = new SAXReader();   
			Document doc= reader.read(f);
			Element root = doc.getRootElement();
			
			File fileName = new File("C:\\Users\\yb\\Desktop\\path.txt");  
        	writer=new FileWriter(fileName);
			
			Element line;  
			Element point;  
			for(Iterator i = root.elementIterator("line"); i.hasNext();) {   
				line = (Element) i.next();  
				if(line.attribute("stationAID").getText().trim().length()==0||line.element("point")==null){
					continue;
				}
			    List<Point> list=new ArrayList<Point>();
			    for(Iterator j = line.elementIterator("point");j.hasNext();) { 
			       point = (Element) j.next();
			       String[] tp_arr=point.getTextTrim().split(",");
			       if(point.attribute("angle")!=null){
			    	   list.add(new Point(Double.parseDouble(tp_arr[0]),Double.parseDouble(tp_arr[1]),point.attribute("angle").getText()));
			       }else{
			    	   list.add(new Point(Double.parseDouble(tp_arr[0]),Double.parseDouble(tp_arr[1])));
			       }
			    }
			    
			    List<Point> upPoints=createPoint(list,"up");
			    List<Point> downPoints=createPoint(list,"down");
			    
			    drawPath(mapcor.get(line.attribute("lineNumber").getText()),upPoints,line,"up",list);
			    drawPath(mapcor.get(line.attribute("lineNumber").getText()),downPoints,line,"down",list);
			}   
			
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}   
	}
	
	public static List<Point> createPoint(List<Point> list,String flag){
		List<Point> relist=new ArrayList<Point>();
		double d=0;
		Point p3=null;
		for(int i=0;i<list.size();i++){
			Point p1=list.get(i);
			Point p=null;
			if(i<list.size()-1){
				Point p2=list.get(i+1);
				if(StringUtils.isNotBlank(p1.getAngle())){
					d=(Double.parseDouble(p1.getAngle())+90)*Math.PI/180;
				}else{
					if(p1.getY()==p2.getY()){
						d=Math.PI/2;
					}else{
						d=Math.atan((p2.getX()-p1.getX())/(p1.getY()-p2.getY()));
					}
					
					if(p2.getX()-p1.getX()>0&&p1.getY()-p2.getY()<0){
						d=Math.abs(d);
					}
				}
				//System.out.println(d);
				if("up".equals(flag)){
					p=new Point(p1.getX()+num*Math.cos(d),p1.getY()+num*Math.sin(d));
				}else{
					p=new Point(p1.getX()-num*Math.cos(d),p1.getY()-num*Math.sin(d));
				}
				p3=new Point(p1.getX()-p.getX(),p1.getY()-p.getY());
				
			}
			
			relist.add(new Point(p1.getX()+p3.getX(),p1.getY()+p3.getY()));
		}
		return relist;
	}
	
	public static void drawPath(String color,List<Point> points,Element line,String flag,List<Point> initPoints){
		String stationIdA=STATIONS.getString(line.attribute("lineNumber").getText()+line.attribute("stationA").getText());
		String stationIdB=STATIONS.getString(line.attribute("lineNumber").getText()+line.attribute("stationB").getText());
		
		String tp=" d=\"M "+points.get(0).getX()+","+points.get(0).getY()+" ";
		String init="od=\"M "+initPoints.get(0).getX()+","+initPoints.get(0).getY()+" ";
		for(int j=1;j<points.size()-1;j++){
			if(points.size()-2>0&&(points.size()-2)%3==0){
				if((points.size()-2)%3==1){
					tp+="C"+points.get(j).getX()+","+points.get(j).getY()+" ";
					init+="C"+initPoints.get(j).getX()+","+initPoints.get(j).getY()+" ";
				}else{
					tp+=points.get(j).getX()+","+points.get(j).getY()+" ";
					init+=initPoints.get(j).getX()+","+initPoints.get(j).getY()+" ";
				}
			}else if(points.size()-2>0&&(points.size()-2)%2==0){
				if((points.size()-2)%2==1){
					tp+="Q"+points.get(j).getX()+","+points.get(j).getY()+" ";
					init+="Q"+initPoints.get(j).getX()+","+initPoints.get(j).getY()+" ";
				}else{
					tp+=points.get(j).getX()+","+points.get(j).getY()+" ";
					init+=initPoints.get(j).getX()+","+initPoints.get(j).getY()+" ";
				}
			}else{
				tp+=points.get(j).getX()+","+points.get(j).getY()+" ";
				init+=initPoints.get(j).getX()+","+initPoints.get(j).getY()+" ";
			}
	    }
		tp+="L"+points.get(points.size()-1).getX()+","+points.get(points.size()-1).getY()+"\"";
		init+="L"+initPoints.get(initPoints.size()-1).getX()+","+initPoints.get(initPoints.size()-1).getY()+"\"";
		
		String path="<path id=\"p"+stationIdA+"-"+stationIdB+"\" "+init;
		if(flag.equals("down")){
			path="<path id=\"p"+stationIdB+"-"+stationIdA+"\"";
		}
	    path+=tp+" fill=\"none\" stroke=\""+color+"\" stroke-width=\""+w+"\" lineid=\""+line.attribute("stationAID").getText().substring(0,2)+"\"/>";
	    
	    try{
        	writer.write(path+"\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
}

package com.util.tos;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.util.Point;
public class ReadLineXmlUtil {
	public static double num=2;//两线之间的距离
	private static FileWriter writer=null;
	public static JSONObject STATIONS=new JSONObject();
	public static int w=2;//线条宽度
	
	
	public static void startDraw() {  
		try {
			SAXReader reader = new SAXReader();   
			Document doc= reader.read(Thread.currentThread().getContextClassLoader().getResource("/stationLineAllSmall.xml"));
			Element root = doc.getRootElement();
			
			File fileName = new File("C:\\Users\\dell\\Desktop\\path.txt");  
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
			    
			    drawPath("#259F3A",upPoints,line,"up");
			    drawPath("#259F3A",downPoints,line,"down");
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
	
	public static void drawPath(String color,List<Point> points,Element line,String flag){
		String stationIdA=STATIONS.getString(line.attribute("lineNumber").getText()+line.attribute("stationA").getText());
		String stationIdB=STATIONS.getString(line.attribute("lineNumber").getText()+line.attribute("stationB").getText());
		
		String path="<path id=\"p"+stationIdB+"-"+stationIdA;
		if(flag.equals("down")){
			path="<path id=\"p"+stationIdA+"-"+stationIdB;
		}
		
		
		String tp="d=\"M"+points.get(0).getX()+","+points.get(0).getY()+" ";
		for(int j=1;j<points.size()-1;j++){
			if(points.size()-2>0&&(points.size()-2)%3==0){
				if((points.size()-2)%3==1){
					tp+="C"+points.get(j).getX()+","+points.get(j).getY()+" ";
				}else{
					tp+=points.get(j).getX()+","+points.get(j).getY()+" ";
				}
			}else if(points.size()-2>0&&(points.size()-2)%2==0){
				if((points.size()-2)%2==1){
					tp+="Q"+points.get(j).getX()+","+points.get(j).getY()+" ";
				}else{
					tp+=points.get(j).getX()+","+points.get(j).getY()+" ";
				}
			}else{
				tp+=points.get(j).getX()+","+points.get(j).getY()+" ";
			}
	    }
		tp+="L"+points.get(points.size()-1).getX()+","+points.get(points.size()-1).getY()+"\"";
		
		
	    path+="\" "+tp+" fill=\"none\" stroke=\""+color+"\" stroke-width=\""+w+"\" lineid=\""+line.attribute("stationAID").getText().substring(0,2)+"\"/>";
	    //System.out.println(path);
	    try{
        	writer.write(path+"\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
}

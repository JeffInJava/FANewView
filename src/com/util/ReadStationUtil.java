package com.util;

import java.io.File;
import java.io.FileWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 
 * 画车站，车站用圆圈表示，颜色和轨道线路色号一致
 *
 */
public class ReadStationUtil {
	public static double x;
	public static double y;
	public static double r=4;
	public static int thickness=1;
	private static FileWriter writer=null;
	
    public static JSONObject STATIONS=new JSONObject();
    public static Map<String,String> mapcor=new HashMap<String,String>();
    
	public static void startDraw() {
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
		
		try{
			File f = new File("C:\\Users\\yb\\Desktop\\CN\\assets\\xml\\stationAllSmall.xml");  
			SAXReader reader = new SAXReader();   
			Document doc= reader.read(f);
			Element root = doc.getRootElement();
			Element station;
			
			File fileName = new File("C:\\Users\\yb\\Desktop\\path.txt");  
        	writer=new FileWriter(fileName);
			
			for(Iterator i =root.elementIterator("Station");i.hasNext();) {   
				station = (Element) i.next();  
				String stationName=station.attribute("StationName").getText().trim();
				x=Double.parseDouble(station.attribute("x").getText().trim());
				y=Double.parseDouble(station.attribute("y").getText().trim());
				
				double stationNamePointX=Double.parseDouble(station.attribute("StationNamePointX").getText().trim());
				double stationNamePointY=Double.parseDouble(station.attribute("StationNamePointY").getText().trim());
				
				//画车站名称文本
				drawText(stationNamePointX,stationNamePointY,stationName);
				
				//是否共线
				boolean isSameSite=Boolean.parseBoolean(station.attribute("isSameSite").getText().trim());
				
				double angle=Double.parseDouble(station.attribute("angle").getText().trim());
				String stationNumber=station.attribute("stationNumber").getText().trim();
				
				String metroLineA=station.attribute("metroLineA").getText().trim();
				String metroLineB=station.attribute("metroLineB").getText().trim();
				String metroLineC=station.attribute("metroLineC").getText().trim();
				String metroLineD=station.attribute("metroLineD").getText().trim();
				
				double angleStationA=Double.parseDouble(station.attribute("angleStationA").getText().trim());
				double angleStationB=Double.parseDouble(station.attribute("angleStationB").getText().trim());
				double angleStationC=Double.parseDouble(station.attribute("angleStationC").getText().trim());
				double angleStationD=Double.parseDouble(station.attribute("angleStationD").getText().trim());
				
				if("1".equals(stationNumber)){
//					draw(init,185+angleStationA+angle,"#259F3A",0,STATIONS.getString(metroLineA+stationName)+"u",x,y);
//					draw(init,5+angleStationA+angle,"#259F3A",0,STATIONS.getString(metroLineA+stationName)+"d",x,y);
					drawCircle(x,y,metroLineA,stationName,mapcor.get(metroLineA));
//				}else if("2".equals(stationNumber)){
//			        double length=r;
//					if(isSameSite){
//						length= r - thickness/ 1.7;
//			        }
//					
//					double a_angle=angle;
//			        double a_x = x+length * Math.cos(a_angle * Math.PI / 180);
//			        double a_y = y+length * Math.sin(a_angle * Math.PI / 180);
////			        draw(init,185+angleStationA,"#259F3A",0,STATIONS.getString(metroLineA+stationName)+"u",a_x,a_y);
////					draw(init,5+angleStationA,"#259F3A",0,STATIONS.getString(metroLineA+stationName)+"d",a_x,a_y);
//					drawCircle(a_x,a_y,metroLineA,STATIONS.getString(metroLineA+stationName),mapcor.get(metroLineA));
//			        
//					double b_angle=angle+180;
//					double b_x = x+length * Math.cos(b_angle*Math.PI / 180);
//					double b_y = y+length * Math.sin(b_angle*Math.PI / 180);
////			        draw(init,185+angleStationB,"#259F3A",0,STATIONS.getString(metroLineB+stationName)+"u",b_x,b_y);
////					draw(init,5+angleStationB,"#259F3A",0,STATIONS.getString(metroLineB+stationName)+"d",b_x,b_y);
//					drawCircle(b_x,b_y,metroLineB,STATIONS.getString(metroLineB+stationName),mapcor.get(metroLineB));
//					
//					
//				}else if("3".equals(stationNumber)){
//					drawThreeStation(angle,angleStationA,"A",isSameSite,STATIONS.getString(metroLineA+stationName),metroLineA);
//					drawThreeStation(angle,angleStationB,"B",isSameSite,STATIONS.getString(metroLineB+stationName),metroLineB);
//					drawThreeStation(angle,angleStationC,"C",isSameSite,STATIONS.getString(metroLineC+stationName),metroLineC);
//				}else if("4".equals(stationNumber)){
//					drawFourStation(angle,angleStationA,"A",STATIONS.getString(metroLineA+stationName),metroLineA);
//					drawFourStation(angle,angleStationB,"B",STATIONS.getString(metroLineB+stationName),metroLineB);
//					drawFourStation(angle,angleStationC,"C",STATIONS.getString(metroLineC+stationName),metroLineC);
//					drawFourStation(angle,angleStationD,"D",STATIONS.getString(metroLineD+stationName),metroLineD);
				}else{
					drawChgCircle(x,y,metroLineA,stationName,"");
				}
				
			}
			
			writer.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public static Point getRotationPoint(Point point){
       double angle = Double.parseDouble(point.getAngle())*Math.PI / 180;
       Point result = new Point(point.getX()* Math.cos(angle) - point.getY() * Math.sin(angle),
    		   point.getX() * Math.sin(angle) + point.getY() * Math.cos(angle));
       return result;
    }
	
	
	public static void drawThreeStation(double p_angle,double angleStation,String station,boolean isSameSite,String stationName,String metroLine){
		double angle=p_angle;
	    if(station == "A"){
	       angle = p_angle;
	    }else if(station == "B"){
	       angle = p_angle + 180;
	    }else if(station == "C"){
	       angle = p_angle + 90;
	    }
	    
	    double length=0;
        if(isSameSite){
            length = r - thickness/ 1.7;
            if(station == "C"){
               length = Math.sqrt(4 * r * r - (r - thickness) * (r - thickness));
            }
        }else{
            length = r;
            if(station == "C"){
               length = r* Math.sqrt(3);
            }
        }
	    angle = 180 - angle;
	    double tp_x =x+length * Math.cos(angle * Math.PI / 180);
	    double tp_y =y+length * Math.sin(angle * Math.PI / 180);
		
//	    draw(init,185+angleStation,"#259F3A",0,stationName+"u",tp_x,tp_y);
//		draw(init,5+angleStation,"#259F3A",0,stationName+"d",tp_x,tp_y);
		
		drawCircle(tp_x,tp_y,metroLine,stationName,mapcor.get(metroLine));
	}
	
	public static void drawFourStation(double p_angle,double angleStation,String station,String stationName,String metroLine){
		double angle = p_angle;
	    if(station == "A"){
	       angle = p_angle;
	    }else if(station == "B"){
	       angle = p_angle + 90;
	    }else if(station == "C"){
	       angle = p_angle + 180;
	    }else if(station == "D"){
	       angle = p_angle + 270;
	    }
	    double length = r * Math.sqrt(2);
	    angle = 180 - angle;
	    double tp_x =x+length * Math.cos(angle * Math.PI / 180);
	    double tp_y =y+length * Math.sin(angle * Math.PI / 180);
	    
//	    draw(init,185+angleStation,"#259F3A",0,stationName+"u",tp_x,tp_y);
//		draw(init,5+angleStation,"#259F3A",0,stationName+"d",tp_x,tp_y);
		
		drawCircle(tp_x,tp_y,metroLine,stationName,mapcor.get(metroLine));
	}
	
	public static void draw(double angle,double startFrom,String color,double alpha,String stationName,double x,double y){
		double angleMid=0;
		angle = Math.abs(angle) > 360?360:angle;
        double n = Math.ceil(Math.abs(angle) / 45);
        double angleA = angle / n;
        angleA = angleA * Math.PI / 180;
        startFrom = startFrom * Math.PI / 180;
        String path="<path id=\"p"+stationName+"\" d=\"M "+(x + r * Math.cos(startFrom))+","+(y + r * Math.sin(startFrom));
        for(int i= 1;i<= n; i++){
           startFrom = startFrom + angleA;
           angleMid = startFrom - angleA / 2;
           double bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
           double by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
           double cx = x + r * Math.cos(startFrom);
           double cy = y + r * Math.sin(startFrom);
           path+=" Q"+bx+","+by+" "+cx+","+cy;
        }
        path+=" L"+(x + r * Math.cos(startFrom))+","+(y + r * Math.sin(startFrom))+"\" fill=\"none\" stroke=\""+color+"\" stroke-width=\"2\"/>";
        //System.out.println(path);
        try{
        	writer.write(path+"\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
	
	//画非换乘车站
	public static void drawCircle(double x,double y,String lineId,String stationName,String color){
		try{
			writer.write("<circle id=\"s"+stationName+"\" cx=\""+x+"\" cy=\""+y+"\" r=\"4\" stroke=\""+color+"\" stroke-width=\"2\" fill=\"white\"/>\n");
        	//writer.write("<circle id=\"c"+stationName+"\" cx=\""+x+"\" cy=\""+y+"\" r=\"3\" fill=\"white\"/>\n");
        	//writer.write("<text x=\""+(x-3)+"\" y=\""+(y+3)+"\" style=\"fill:black;font-size:8px;\">"+(lineId.equals("41")?"浦":lineId)+"</text>\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
	
	//画换乘车站
	public static void drawChgCircle(double x,double y,String lineId,String stationName,String color){
		try{
			writer.write("<image id=\"s"+stationName+"\" xlink:href=\"style/images/chgstation.png\" x=\""+x+"\" y=\""+y+"\" width=\"10px\" height=\"10px\"/>\n");
			//writer.write("<circle id=\"s"+stationName+"\" cx=\""+x+"\" cy=\""+y+"\" r=\"4\" stroke=\"#FFFFFF\" stroke-width=\"2\" fill=\"#132538\"/>\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
	
	public static void drawText(double x,double y,String name){
		try{
			writer.write("<text id=\""+name+"\" x=\""+x+"\" y=\""+(y+8)+"\" style=\"fill:white;font-size:8px;\">"+name+"</text>\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}

	
}

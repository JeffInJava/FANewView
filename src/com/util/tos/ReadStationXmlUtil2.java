package com.util.tos;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.util.Point;
/**
 * 月平均客流图中使用的车站图
 *
 */
public class ReadStationXmlUtil2 {
	public static double x;
	public static double y;
	public static double r=4;
	public static int thickness=1;
	private static FileWriter writer=null;
	
	private static int init=170;
	
	private static double peripheryLength = 0;
    private static double peripheryWidth = 0;

    public static JSONObject STATIONS=new JSONObject();
    
    public static void main(String args[]){
    	startDraw();
    }
    
	public static void startDraw() {
		try{
			SAXReader reader = new SAXReader();   
			Document doc= reader.read(Thread.currentThread().getContextClassLoader().getResource("/stationAllSmall.xml"));
			Element root = doc.getRootElement();
			Element station;
			
			File fileName = new File("C:\\Users\\dell\\Desktop\\path.txt");  
        	writer=new FileWriter(fileName);
			
			for(Iterator i =root.elementIterator("Station");i.hasNext();) {   
				station = (Element) i.next();  
				String stationName=station.attribute("StationName").getText().trim();
				x=Double.parseDouble(station.attribute("x").getText().trim());
				y=Double.parseDouble(station.attribute("y").getText().trim());
				
				double stationNamePointX=Double.parseDouble(station.attribute("StationNamePointX").getText().trim());
				double stationNamePointY=Double.parseDouble(station.attribute("StationNamePointY").getText().trim());
				
				
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
					drawCircle(x,y,metroLineA,STATIONS.getString(metroLineA+stationName),stationName,false);
				}else if("2".equals(stationNumber)){
			        double length=r;
			        peripheryLength=20;
					if(isSameSite){
						length= r - thickness/ 1.7;
						peripheryLength=19;
			        }
					
					drawLinePeripheryTwin(angle,stationName);
					
					double a_angle=angle;
			        double a_x = x+length * Math.cos(a_angle * Math.PI / 180);
			        double a_y = y+length * Math.sin(a_angle * Math.PI / 180);
					drawCircle(a_x,a_y,metroLineA,STATIONS.getString(metroLineA+stationName),stationName,true);
			        
					double b_angle=angle+180;
					double b_x = x+length * Math.cos(b_angle*Math.PI / 180);
					double b_y = y+length * Math.sin(b_angle*Math.PI / 180);
					drawCircle(b_x,b_y,metroLineB,STATIONS.getString(metroLineB+stationName),stationName,true);
					
				}else if("3".equals(stationNumber)){
					peripheryLength=10;
					if(isSameSite){
						peripheryWidth = 9;
			        }else{
			        	peripheryWidth = peripheryLength;
			        }
					drawLinePeripheryThree(angle,stationName);
					
					drawThreeStation(angle,angleStationA,"A",isSameSite,STATIONS.getString(metroLineA+stationName),stationName,metroLineA);
					drawThreeStation(angle,angleStationB,"B",isSameSite,STATIONS.getString(metroLineB+stationName),stationName,metroLineB);
					drawThreeStation(angle,angleStationC,"C",isSameSite,STATIONS.getString(metroLineC+stationName),stationName,metroLineC);
				}else if("4".equals(stationNumber)){
					peripheryWidth = 14;
					peripheryLength=22;
					drawLinePeripheryFour(angle,stationName);
					
					drawFourStation(angle,angleStationA,"A",STATIONS.getString(metroLineA+stationName),stationName,metroLineA);
					drawFourStation(angle,angleStationB,"B",STATIONS.getString(metroLineB+stationName),stationName,metroLineB);
					drawFourStation(angle,angleStationC,"C",STATIONS.getString(metroLineC+stationName),stationName,metroLineC);
					drawFourStation(angle,angleStationD,"D",STATIONS.getString(metroLineD+stationName),stationName,metroLineD);
				}
				
				//画车站名称文本
				//drawText(stationNamePointX,stationNamePointY,stationName);
				
			}
			
			for(Iterator i =root.elementIterator("Station");i.hasNext();) {   
				station = (Element) i.next();  
				String stationName=station.attribute("StationName").getText().trim();
				double stationNamePointX=Double.parseDouble(station.attribute("StationNamePointX").getText().trim());
				double stationNamePointY=Double.parseDouble(station.attribute("StationNamePointY").getText().trim());
				//画车站名称文本
				drawText(stationNamePointX,stationNamePointY,stationName);
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
	
	//画两站换乘车站的外围线
	public static void drawLinePeripheryTwin(double ag,String stationName){
		peripheryWidth = 11;
		
		String path="<path id=\"chg"+stationName+"\" d=\"";
		double angleMid = 0;
		double bx = 0;
		double by = 0;
		double cx = 0;
		double cy = 0;
		Point b = null;
		Point c = null;
	    
	    double x = 0;
	    double y = 0;
	    double r = peripheryWidth / 2;
	    double angle = 180;
	    double startFrom = 90;
	    
	    angle = Math.abs(angle) > 360?360:angle;
	    double n = Math.ceil(Math.abs(angle) / 45);
	    double angleA = angle / n;
	    angleA = angleA * Math.PI / 180;
	    startFrom = startFrom * Math.PI / 180;
	    
	    Point p = new Point(0,peripheryWidth / 2,ag+"");
	    p = getRotationPoint(p);
	    path+="M"+(p.getX()+ReadStationXmlUtil2.x)+","+(p.getY()+ReadStationXmlUtil2.y);
	    double halfLength = peripheryLength / 2 - peripheryWidth / 2;
	    Point p2 = new Point(-halfLength,peripheryWidth / 2,ag+"");
	    p2 = getRotationPoint(p2);
	    path+=" "+(p2.getX()+ReadStationXmlUtil2.x)+","+(p2.getY()+ReadStationXmlUtil2.y);
	    x = -halfLength;
	    y = 0;
	    int i = 0;
	    for(i = 1; i <= n; i++){
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    Point p3 = new Point(halfLength,-peripheryWidth / 2,ag+"");
	    p3 = getRotationPoint(p3);
	    path+=" L"+(p3.getX()+ReadStationXmlUtil2.x)+","+(p3.getY()+ReadStationXmlUtil2.y);
	    x = halfLength;
	    y = 0;
	    angleA = angle / n;
	    angleA = angleA * Math.PI / 180;
	    startFrom = -90;
	    startFrom = startFrom * Math.PI / 180;
	    for(i = 1; i <= n; i++){
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    Point p4 = new Point(0,peripheryWidth / 2,ag+"");
	    p4 = getRotationPoint(p4);
	    path+=" L"+(p4.getX()+ReadStationXmlUtil2.x)+","+(p4.getY()+ReadStationXmlUtil2.y)+"\" fill=\"#555555\" stroke=\"green\" stroke-width=\"2\"/>";
	    //System.out.println(path);
	    try{
        	writer.write(path+"\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
	
	public static List<Point> getKeyPoints(double angle,int stations){
		List result=new ArrayList();
		if(stations==3){
			double radius = peripheryLength / 2;
			Point pA = new Point(-(peripheryWidth / 2),radius);
	        result.add(pA);
	        Point pB = new Point(-radius * Math.cos(angle),-peripheryLength * Math.cos(angle) - radius * Math.sin(angle));
	        result.add(pB);
	        Point pC = new Point(peripheryWidth / 2 + radius * Math.cos(angle),-radius * Math.sin(angle));
	        result.add(pC);
		}else if(stations==4){
	        double radius = (peripheryLength - peripheryWidth) / 2;
	        double line1 = peripheryWidth * Math.sqrt(2) / 2;
	        double line2 = radius * Math.sqrt(2) / 2;
	        Point pA = new Point(line2,line1 + line2);
	        result.add(pA);
	        Point pB = new Point(-line1 - line2,line2);
	        result.add(pB);
	        Point pC = new Point(-line2,-line1 - line2);
	        result.add(pC);
	        Point pD = new Point(line1 + line2,-line2);
	        result.add(pD);
		}
		return result;
	}
	
	//画三站换乘车站的外围线
	public static void drawLinePeripheryThree(double ag,String stationName){
		String path="<path id=\"chg"+stationName+"\" d=\"";
		ag=180-ag;
		
		int i = 0;
	    double angleMid = 0;
	    double bx = 0;
	    double by = 0;
	    double cx = 0;
	    double cy = 0;
	    Point b = null;
	    Point c = null;
	    double x = 0;
	    double y = 0;
	    double r = peripheryLength / 2;
	    double angle=Math.asin(peripheryWidth / 2 / peripheryLength);
	    
	    List<Point> arrPoint=getKeyPoints(angle,3);
	    double n = Math.ceil(Math.abs((angle + Math.PI / 2) * 180 / Math.PI) / 45);
	    double angleA = (angle + Math.PI / 2) / n;
	    double startFrom = 90;
	    startFrom = startFrom * Math.PI / 180;
	    Point pA = new Point(arrPoint.get(0).getX(),arrPoint.get(0).getY(),ag+"");
	    pA = getRotationPoint(pA);
	    path+="M"+(pA.getX()+ReadStationXmlUtil2.x)+","+(pA.getY()+ReadStationXmlUtil2.y);
	    x = -(peripheryWidth / 2);
	    y = 0;
	    for(i = 1; i <= n; i++)
	    {
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    Point pB = new Point(arrPoint.get(1).getX(),arrPoint.get(1).getY(),ag+"");
	    pB = getRotationPoint(pB);
	    path+=" L"+(pB.getX()+ReadStationXmlUtil2.x)+","+(pB.getY()+ReadStationXmlUtil2.y);
	    
	    x = 0;
	    y = -peripheryLength * Math.cos(angle);
	    n = Math.ceil(Math.abs((Math.PI - 2 * angle) * 180 / Math.PI) / 45);
	    angleA = (Math.PI - 2 * angle) / n;
	    startFrom = -Math.PI + angle;
	    for(i = 1; i <= n; i++)
	    {
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    
	    Point pC = new Point(arrPoint.get(2).getX(),arrPoint.get(2).getY(),ag+"");
	    pC = getRotationPoint(pC);
	    path+=" L"+(pC.getX()+ReadStationXmlUtil2.x)+","+(pC.getY()+ReadStationXmlUtil2.y);
	    x = peripheryWidth / 2;
	    y = 0;
	    n = Math.ceil(Math.abs((angle + Math.PI / 2) * 180 / Math.PI) / 45);
	    angleA = (angle + Math.PI / 2) / n;
	    startFrom = -angle;
	    for(i = 1; i <= n; i++)
	    {
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    
	    path+=" L"+(pA.getX()+ReadStationXmlUtil2.x)+","+(pA.getY()+ReadStationXmlUtil2.y)+"\" fill=\"#555555\" stroke=\"green\" stroke-width=\"2\"/>";
	    //System.out.println(path);
	    try{
        	writer.write(path+"\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
	
	
	
	//画四站换乘车站的外围线
	public static void drawLinePeripheryFour(double ag,String stationName){
		String path="<path id=\"chg"+stationName+"\" d=\"";
		ag = 180 - ag;
		
		double startFrom = 0;
	    int i = 0;
	    double angleMid = 0;
	    double bx=0;
	    double by=0;
	    double cx=0;
	    double cy=0;
	    Point b = null;
	    Point c = null;
	    
	    double x = 0;
	    double y = 0;
	    double r = (peripheryLength - peripheryWidth) / 2;
	    double line1 = peripheryWidth * Math.sqrt(2) / 2;
	    double line2 = r * Math.sqrt(2) / 2;
	    double angle = 90;
	    List<Point> arrPoint=getKeyPoints(angle,4);
	    double n = Math.ceil(angle / 45);
	    double angleA = angle / n;
	    angleA = angleA * Math.PI / 180;
	    Point pA = new Point(arrPoint.get(0).getX(),arrPoint.get(0).getY(),ag+"");
	    pA = getRotationPoint(pA);
	    path+="M"+(pA.getX()+ReadStationXmlUtil2.x)+","+(pA.getY()+ReadStationXmlUtil2.y);
	    
	    x = 0;
	    y = line1;
	    startFrom = 45 * Math.PI / 180;
	    for(i = 1; i <= n; i++)
	    {
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    Point pB = new Point(arrPoint.get(1).getX(),arrPoint.get(1).getY(),ag+"");
	    pB = getRotationPoint(pB);
	    path+=" L"+(pB.getX()+ReadStationXmlUtil2.x)+","+(pB.getY()+ReadStationXmlUtil2.y);
	    
	    x = -line1;
	    y = 0;
	    startFrom = 135 * Math.PI / 180;
	    for(i = 1; i <= n; i++)
	    {
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    Point pC = new Point(arrPoint.get(2).getX(),arrPoint.get(2).getY(),ag+"");
	    pC = getRotationPoint(pC);
	    path+=" L"+(pC.getX()+ReadStationXmlUtil2.x)+","+(pC.getY()+ReadStationXmlUtil2.y);
	    
	    x = 0;
	    y = -line1;
	    startFrom = 225 * Math.PI / 180;
	    for(i = 1; i <= n; i++)
	    {
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    Point pD = new Point(arrPoint.get(3).getX(),arrPoint.get(3).getY(),ag+"");
	    pD = getRotationPoint(pD);
	    path+=" L"+(pD.getX()+ReadStationXmlUtil2.x)+","+(pD.getY()+ReadStationXmlUtil2.y);
	    
	    x = line1;
	    y = 0;
	    startFrom = 315 * Math.PI / 180;
	    for(i = 1; i <= n; i++)
	    {
	       startFrom = startFrom + angleA;
	       angleMid = startFrom - angleA / 2;
	       bx = x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
	       by = y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
	       cx = x + r * Math.cos(startFrom);
	       cy = y + r * Math.sin(startFrom);
	       b = getRotationPoint(new Point(bx,by,ag+""));
	       c = getRotationPoint(new Point(cx,cy,ag+""));
	       path+=" Q"+(b.getX()+ReadStationXmlUtil2.x)+","+(b.getY()+ReadStationXmlUtil2.y)+" "+(c.getX()+ReadStationXmlUtil2.x)+","+(c.getY()+ReadStationXmlUtil2.y);
	    }
	    path+=" L"+(pA.getX()+ReadStationXmlUtil2.x)+","+(pA.getY()+ReadStationXmlUtil2.y)+"\" fill=\"#555555\" stroke=\"green\" stroke-width=\"2\"/>";
	    
	    try{
        	writer.write(path+"\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}
	
	
	
	//画三站换乘车站
	public static void drawThreeStation(double p_angle,double angleStation,String station,boolean isSameSite,String stationId,String stationName,String metroLine){
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
	    
		drawCircle(tp_x,tp_y,metroLine,stationId,stationName,true);
	}
	
	//画四站换乘车站
	public static void drawFourStation(double p_angle,double angleStation,String station,String stationId,String stationName,String metroLine){
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
	    
		drawCircle(tp_x,tp_y,metroLine,stationId,stationName,true);
	}
	
	public static void drawCircle(double x,double y,String lineId,String stationId,String stationName,boolean ischg){
		try{
        	writer.write("<circle id=\"p"+stationId+"\" cx=\""+x+"\" cy=\""+y+"\" r=\"4\" stroke=\"black\" stroke-width=\"0.3\" fill=\"green\" stationName=\""+lineId+"-"+stationName+"\"/>\n");
        	if(ischg){
        		if(lineId.length()>1){
            		writer.write("<text x=\""+(x-3)+"\" y=\""+(y+2)+"\" style=\"fill:black;font-size:6px;\">"+(lineId.equals("41")?"浦":lineId)+"</text>\n");
            	}else{
            		writer.write("<text x=\""+(x-1)+"\" y=\""+(y+2)+"\" style=\"fill:black;font-size:6px;\">"+(lineId.equals("41")?"浦":lineId)+"</text>\n");
            	}
        	}
		}catch(Exception e){
        	e.printStackTrace();
        }
	}
	
	public static void drawText(double x,double y,String name){
		try{
			writer.write("<text x=\""+x+"\" y=\""+(y+7)+"\" style=\"fill:black;font-size:8px;\" id=\""+name+"\">"+name+"</text>\n");
        }catch(Exception e){
        	e.printStackTrace();
        }
	}

	
}

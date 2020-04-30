package com.util;

public class Point {
	private double x;
	private double y;
	private String angle;
	
	public Point() {
		super();
	}
	public Point(double x, double y) {
		super();
		this.x = x;
		this.y = y;
	}
	public Point(double x, double y,String angle) {
		super();
		this.x = x;
		this.y = y;
		this.angle=angle;
	}
	public double getX() {
		return (double)Math.round(x*100)/100;
	}
	public void setX(double x) {
		this.x = x;
	}
	public double getY() {
		return (double)Math.round(y*100)/100;
	}
	public void setY(double y) {
		this.y = y;
	}
	public String getAngle() {
		return angle;
	}
	public void setAngle(String angle) {
		this.angle = angle;
	}
	
}

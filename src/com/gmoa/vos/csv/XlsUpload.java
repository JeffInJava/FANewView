package com.gmoa.vos.csv;

import java.io.FileInputStream;
import java.sql.PreparedStatement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;

import com.gmoa.util.PropertiesUtil;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.annotation.file.JsonTagUploadAction;
import jsontag.annotation.onlineapi.JtOnlineApi;
import jsontag.bean.handler.file.upload.FileAttrBean;
import jsontag.bean.handler.file.upload.UploadFileBean;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.file.ICustomPath;
import jsontag.interf.file.jt.IJtUpload;

/**
 * csv数据上传
 * 
 * @author Jeff
 * 
 */
@JtOnlineApi(name = "csv上传", describe = "")
@JsonTagAnnotation(actionValue = "/upload.action", namespace = "xls")
@JsonTagUploadAction(permitFileSize = 5120, fileCharset = "UTF-8")
public class XlsUpload extends JsonTagTemplateDaoImpl implements IJtUpload, ICustomPath {

	private static final Logger logger = Logger.getLogger(XlsUpload.class);

	@Override
	public String getCustomPath() throws Exception {
		String path = PropertiesUtil.getProperties().getProperty("UPLOAD_CSV");
		return path;
	}

	@Override
	public Object doUpload(List<UploadFileBean> uploadFileBeanList) throws Exception {
		UploadFileBean ufb = uploadFileBeanList.get(0);
		if (ufb.getFileAttrBeanList() == null || ufb.getFileAttrBeanList().size() == 0)
			throw new Exception("无上传文件");
		FileAttrBean fab = ufb.getFileAttrBeanList().get(0);
		excelParse(fab.getAbsolutePath(), fab.getSourceName());
		return "xls导入成功！";
	}

	private void excelParse(String relativePath, String lineId) throws Exception {

		Workbook xwb = WorkbookFactory.create(new FileInputStream(relativePath));
		Sheet sheet = xwb.getSheetAt(0); // 示意访问sheet
		// 定义 row、cell
		Row row;
		int rowNum;
		rowNum = sheet.getLastRowNum();

		// 开始结束站
		Map<Integer, String> stas = new HashMap<Integer, String>();
		Integer stasKey = null;
		String stasValue = null;
		// 总列数
		Integer cellNum = null;

		// 数据库字段
		String isUpdown = null;
		String startSt = null;
		String endSt = null;
		Integer trainCap = null;
		String startTime = null;
		String endTime = null;

		// 临时字段
		String timeSeg[] = null;
		String fmtLineId = lineId.split("\\.")[0];
		Map<String, Object> staBeg = null;
		Map<String, Object> staEnd = null;
		String staBegId = null;
		String staEndId = null;
		String sql = "insert into tbl_traincap_division (IS_UPDOWN,IS_WORKDAY,LINE_ID,STAR_ST,END_ST,"
				+ "TRAINCAP,START_TIME,END_TIME) values(?,?,?,?,?,?,?,?)";

		String staIdsql = " select station_id from viw_metro_station_name where line_id='" + fmtLineId + "' "
				+ " and start_time<='20200315' and end_time>='20200315' ";
		String stationNameBeg = null;
		String stationNameEnd = null;

		final List<Object[]> dataSet = new ArrayList<Object[]>();
		Object[] pob = null;
		boolean downDirection = true;// 默认下行
		for (int i = 0; i <= rowNum; i++) {
			// 读取行
			row = sheet.getRow(i);
			System.out.println("执行序号：-----【" + row.getCell(0) + "】-----");
			if (i == 0) {
				// 总列数
				cellNum = row.getPhysicalNumberOfCells();
				for (int j = 3; j < cellNum; j++) {
					stas.put(Integer.valueOf(j), getValue(row.getCell(j)));
				}
			} else {

				// 数据行列
				if (getValue(row.getCell(1)).equals("上行")) {
					isUpdown = "1";
					downDirection = false;
				} else {
					isUpdown = "2";
					downDirection = true;
				}
				timeSeg = getValue(row.getCell(2)).split("-");
				startTime = timeSeg[0].split(":")[0];
				endTime = timeSeg[1].split(":")[0];
				for (Map.Entry<Integer, String> entry : stas.entrySet()) {
					stasKey = entry.getKey();
					stasValue = entry.getValue();
					System.out.println("数列名称：----------【" + stasValue + "】----------");
					trainCap = Integer.parseInt(row.getCell(stasKey).toString());
					if (downDirection) {
						startSt = stasValue.split("->")[0];
						endSt = stasValue.split("->")[1];
					} else {
						startSt = stasValue.split("->")[1];
						endSt = stasValue.split("->")[0];
					}

					stationNameBeg = staIdsql + " and station_nm_cn='" + startSt + "'";
					stationNameEnd = staIdsql + " and station_nm_cn='" + endSt + "'";
					try {
						staBeg = this.jsonTagJdbcDao.getJdbcTemplate().queryForMap(stationNameBeg);
					} catch (Exception e) {
						System.out.println("-------error-------开始车站名称：【" + startSt + "】不正确--------------");
					}
					staBegId = String.valueOf(staBeg.get("STATION_ID"));
					try {
						staEnd = this.jsonTagJdbcDao.getJdbcTemplate().queryForMap(stationNameEnd);
					} catch (Exception e) {
						System.out.println("-------error-------结束车站名称：【" + endSt + "】不正确");
					}
					staEndId = String.valueOf(staEnd.get("STATION_ID"));
					pob = new Object[8];
					pob[0] = isUpdown;
					pob[1] = "0";
					pob[2] = fmtLineId;
					pob[3] = staBegId;
					pob[4] = staEndId;
					pob[5] = trainCap;
					pob[6] = startTime;
					pob[7] = endTime;
					dataSet.add(pob);
				}
			}
		}
		BatchPreparedStatementSetter setter = null;
		setter = new BatchPreparedStatementSetter() {
			public void setValues(PreparedStatement ps, int i) throws java.sql.SQLException {
				Object[] obj = dataSet.get(i);
				ps.setString(1, obj[0].toString());
				ps.setString(2, "0");
				ps.setString(3, obj[2].toString());
				ps.setString(4, obj[3].toString());
				ps.setString(5, obj[4].toString());
				ps.setInt(6, Integer.parseInt(obj[5].toString()));
				ps.setString(7, obj[6].toString());
				ps.setString(8, obj[7].toString());
			}
			public int getBatchSize() {
				return dataSet.size();
			}
		};
		this.jsonTagJdbcDao.getJdbcTemplate().batchUpdate(sql, setter);
	}

	@SuppressWarnings("unused")
	private String getValue(Cell xssfCell) {
		if (xssfCell == null || (xssfCell.getCellType() == xssfCell.CELL_TYPE_ERROR))
			return "";
		if (xssfCell.getCellType() == xssfCell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(xssfCell.getBooleanCellValue()).trim();
		} else if (xssfCell.getCellType() == xssfCell.CELL_TYPE_NUMERIC) {
			short format = xssfCell.getCellStyle().getDataFormat();
			SimpleDateFormat sdf = null;
			if (format == 14 || format == 31 || format == 57 || format == 58) {
				// 日期
				sdf = new SimpleDateFormat("yyyy-MM-dd");
				double value = xssfCell.getNumericCellValue();
				Date date = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(value);
				return sdf.format(date).trim();
			} else if (format == 49) {
				DecimalFormat df = new DecimalFormat("0");
				return df.format(xssfCell.getNumericCellValue());
			} else {
				return String.valueOf(xssfCell.getNumericCellValue()).trim();
			}
		} else {
			return String.valueOf(xssfCell.getStringCellValue()).trim();
		}
	}

}

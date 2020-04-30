package com.gmoa.vos.csv;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.List;

import org.apache.log4j.Logger;

import com.gmoa.util.PropertiesUtil;
import com.opencsv.CSVParser;
import com.opencsv.CSVParserBuilder;
import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;

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
@JsonTagAnnotation(actionValue = "/upload.action", namespace = "csv")
@JsonTagUploadAction(permitFileSize = 5120, fileCharset = "UTF-8")
public class CsvUpload extends JsonTagTemplateDaoImpl implements IJtUpload, ICustomPath {

	private static final Logger logger = Logger.getLogger(CsvUpload.class);

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
		csvParse(fab.getAbsolutePath());
		return "csv导入成功！";
	}

	private void csvParse(String relativePath) throws Exception {

		CSVParser csvParser = new CSVParserBuilder().withSeparator('\t').build();
		CSVParser csvParserAli = new CSVParserBuilder().withSeparator(',').build();
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(relativePath), "UTF-8"));
		BufferedReader brAli = new BufferedReader(new InputStreamReader(new FileInputStream(relativePath), "GBk"));
		CSVReader reader = new CSVReaderBuilder(br).withCSVParser(csvParser).build();
		CSVReader readerAli = new CSVReaderBuilder(brAli).withCSVParser(csvParserAli).build();
		List<String[]> strings = reader.readAll();
		List<String[]> stringsAli = readerAli.readAll();
		boolean aliPayFlag = false;
		if (strings.get(0)[0].trim().contains("支付宝") || stringsAli.get(0)[0].trim().contains("支付宝")) {
			aliPayFlag = true;
		}
		String content[] = null;

		/*** 入库字段 ***/
		String dealTime = null;// 交易日期
		Integer timesRemain = null;// 支付方式 1支付宝 2微信 3付费通
		Integer ticketType = null;// 票卡类型，100单程票 132一日票 136三日票;
		int exceptType = 56;// 交易类型：默认都是当面付
		String stationId = null;// 车站ID
		String equipId = null;// 设备
		String tradeNo = null;// 商户订单号
		String ticketNo = null;// 第三方支付平台订单号
		String tradeTime = null;// 交易时间
		BigDecimal totalAmount = BigDecimal.ZERO;// 总金额
		Integer countNum = null;// 张数
		BigDecimal amount = null;// 单价
		Integer serviceType = null;// 业务类型,1付款 2退款
		/******/
		BigDecimal refund = BigDecimal.ZERO;// 退款金额
		String productName[] = null;// 商品名称
		int wechatLine = 2;
		int alipayLine = 6;
		int count = 0;
		int countAli = 0;

		String sql = "insert into TBL_CLOUD_THREE_DETAIL (STMT_DAY,TIMES_REMAIN,TICKET_TYPE,EXCEPT_TYPE,STATION_ID,"
				+ "EQUIP_ID,TRADE_NO,TICKET_NO,TRADE_TIME,TOTAL_AMOUNT,COUNT_NUM,AMOUNT,SERVICE_TYPE)"
				+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		if (aliPayFlag) {
			for (String s[] : stringsAli) {
				countAli++;
				if (countAli < alipayLine || countAli >= stringsAli.size() - 3)
					continue;
				// 交易日期
				dealTime = s[0].trim().substring(0, 8);
				// 支付方式
				timesRemain = 1;
				// 票卡类型
				if (s[3].contains("单程票")) {
					ticketType = 100;
				} else if (s[3].contains("三日票")) {
					ticketType = 136;
				} else {
					ticketType = 132;
				}

				// 车站Id
				stationId = s[6].trim().substring(0, 4);
				// 设备
				equipId = s[9].trim();
				// 商户订单号
				tradeNo = s[1].trim();
				// 第三方支付平台订单号
				ticketNo = s[0].trim();
				// 交易时间
				tradeTime = s[5].trim().replace("-", "").replace(":", "").replace(" ", "");
				// 总金额
				totalAmount = new BigDecimal(s[11].trim());
				if (s[3].contains("云购票机")) {
					productName = s[3].substring(s[3].lastIndexOf("-") + 1, s[3].length()).split(";");
					countNum = Integer.parseInt(productName[0]);
					amount = new BigDecimal((productName[1].trim()));
				} else {
					countNum = 0;
					amount = BigDecimal.ZERO;
				}

				// 业务类型
				if (s[2].contains("交易")) {
					serviceType = 1;
				} else {
					serviceType = 2;
				}
				this.jsonTagJdbcDao.getJdbcTemplate().update(sql, dealTime, timesRemain, ticketType, exceptType,
						stationId, equipId, tradeNo, ticketNo, tradeTime, totalAmount, countNum, amount, serviceType);
			}
		} else {
			for (String s[] : strings) {
				count++;

				content = s[0].split(",");

				// 最后两行不需要解析
				if (count >= strings.size() - 1 || count < wechatLine)
					continue;

				// 交易日期
				dealTime = content[0].trim().replace("`", "").replace("-", "").substring(0, 8);
				// 支付方式
				timesRemain = 2;
				// 票卡类型
				if (content[20].contains("单程票")) {
					ticketType = 100;
				} else if (content[20].contains("三日票")) {
					ticketType = 136;
				} else {
					ticketType = 132;
				}
				// 车站Id
				stationId = content[4].replace("`", "").trim().substring(0, 4);
				// 设备
				equipId = content[4].replace("`", "").trim();
				// 商户订单号
				tradeNo = content[6].replace("`", "").trim();
				// 第三方支付平台订单号
				ticketNo = content[5].replace("`", "").trim();
				// 交易时间
				tradeTime = content[0].trim().replace("`", "").replace("-", "").replace(":", "").replace(" ", "");
				// 总金额
				totalAmount = new BigDecimal(content[12].replace("`", "").trim());
				// 张数
				countNum = Integer.parseInt(content[21].replace("`", "").split(";")[0]);
				// 单价
				amount = new BigDecimal(content[21].replace("`", "").split(";")[1]).divide(new BigDecimal(100));
				// 业务类型
				refund = new BigDecimal(content[16].replace("`", "").trim());
				if (refund.compareTo(BigDecimal.ZERO) > 0) {
					serviceType = 2;
				} else {
					serviceType = 1;
				}
				this.jsonTagJdbcDao.getJdbcTemplate().update(sql, dealTime, timesRemain, ticketType, exceptType,
						stationId, equipId, tradeNo, ticketNo, tradeTime, totalAmount, countNum, amount, serviceType);
			}
		}

	}

	public static void main(String[] args) {
		String ss = "云购票机-单程票-1;3.00";
		System.out.println(ss.lastIndexOf("-"));
		System.out.println(ss.substring(ss.lastIndexOf("-") + 1, ss.length()));
	}

}

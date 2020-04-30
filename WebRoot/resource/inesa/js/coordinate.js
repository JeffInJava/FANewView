//设置echarts坐标轴的最大及最小值
function mdf_range(max_amount_y1, min_amount_y1, max_amount_y2) {
	var coordinate_v = [];
	var split_nums = 5;
	var abs_max_values;
	var max_values_y1;
	var min_values_y1;
	var max_values_y2;
	var min_values_y2;
	var up_split;
	var down_split;
	// y1
	var min_max_range = Math.abs(max_amount_y1) + Math.abs(min_amount_y1);
	abs_max_values = fetchMaxValue(min_max_range);
	// 每个split的差值
	var split_v_y1;
	// y1 x轴上面分行数
	var max_v_ratio;
	// y2最大值
	max_values_y2 = fetchMaxValue(max_amount_y2);
	// series 都在上
	if (parseFloat(min_amount_y1) >= 0) {
		max_values_y1 = abs_max_values;
		min_values_y1 = 0;
		min_values_y2 = 0;
	}
	// series 都在下
	else if (parseFloat(max_amount_y1) <= 0) {
		split_v_y1 = abs_max_values / (split_nums - 1);
		max_values_y1 = split_v_y1;
		min_values_y1 = -1 * abs_max_values;
		min_values_y2 = max_values_y2 * -4;
	}
	// series 一上一下
	else {
		split_v_y1 = abs_max_values / split_nums;
		max_v_ratio = Math.ceil(parseFloat(max_amount_y1) / split_v_y1)
		var min_val_curr = (split_nums - max_v_ratio) * split_v_y1 * -1;
		if (Math.abs(min_val_curr) < Math.abs(min_amount_y1)) {
			split_v_y1 = split_v_y1 * 2;
		}
		max_values_y1 = max_v_ratio * split_v_y1;
		min_values_y1 = (split_nums - max_v_ratio) * split_v_y1 * -1;
		max_values_y2 = Math.ceil((max_values_y2 / max_v_ratio)) * max_v_ratio;
		min_values_y2 = (max_values_y2 / max_v_ratio)
				* -(split_nums - max_v_ratio);
	}
	// 返回数据
	coordinate_v.push(max_values_y1);
	coordinate_v.push(min_values_y1);
	coordinate_v.push(max_values_y2);
	coordinate_v.push(min_values_y2);
	return coordinate_v;
}
function fetchMaxValue(paramVal) {
	var mult = [ 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000 ];
	var ratio;
	var unitRat;
	if (paramVal > 10) {
		for ( var j in mult) {
			var mt = mult[j];
			if (paramVal / mt < 10) {
				ratio = mt;
				break;
			}
		}
		unitRat = parseInt(paramVal.toString().substring(0, 1));
		return (unitRat + 1) * ratio;
	} else {
		return 10;
	}

}

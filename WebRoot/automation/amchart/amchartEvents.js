/**
 * This function is called when the chart is fully loaded and initialized. 
 */
function amChartInited(chart_id){
	var SWFObject = Ext.get(chart_id);
	SWFObject.owner.fireEvent('afterInited', chart_id);
}

/**
 * This function is called when you request data from a chart by calling the flashMove.getData() function.
 * @param {} chart_id
 * @param {} data
 */
function amReturnData(chart_id, data){
	var SWFObject = Ext.get(chart_id);
	SWFObject.owner.data_ = data;
}

/**
 * This function is called when you request settings from a chart by calling the flashMove.getSettings() function. 
 * @param {} chart_id
 * @param {} settings
 */
function amReturnSettings(chart_id, settings) {
	var SWFObject = Ext.get(chart_id);
	SWFObject.owner.settings_ = settings;
}

/**
 * When exporting chart as an image, the chart passes image data to this function. 
 * @param {} chart_id
 * @param {} data
 */
function amReturnImageData(chart_id, data) {
}

/**
 * This function is called when you request a setting from a chart by calling the flashMovie.getParam(param) function.
 * @param {} chart_id
 * @param {} param
 */
function amReturnParam(chart_id, param) {
}

/**
 * This function is called when an error occurs, such as no data, or file not found. 
 * @param {} chart_id
 * @param {} message
 */
function amError(chart_id, message){
}

/**
 * This function is called when the chart finishes doing some task triggered by another JavaScript function.
 * @param {} chart_id
 * @param {} process_name
 */
function amProcessCompleted(chart_id, process_name){
}


/*-----------------------column--------------------------*/
/**
 * This function is called when user clicks on a bullet. 
 * @param {} chart_id
 * @param {} graph_index
 * @param {} value
 * @param {} series
 * @param {} url
 * @param {} description
 */
function amClickedOnBullet(chart_id,graph_index,value,series,url,description){
	var SWFObject = Ext.get(chart_id);
	SWFObject.owner.fireEvent('clickedOnBullet',chart_id,graph_index,value,series,url,description);
}	
/**
 * This function is called when the user rolls over a bullet. 
 * @param {} chart_id
 * @param {} graph_index
 * @param {} value
 * @param {} series
 * @param {} url
 * @param {} description
 */
function amRolledOverBullet(chart_id, graph_index, value, series, url, description){
	var SWFObject = Ext.get(chart_id);
	SWFObject.owner.fireEvent('rolledOverBullet',chart_id,graph_index,value,series,url,description);
}

/*-------------------------line-------------------------*/
/**
 * This function is called when the selected period is changed, also when the chart is initialized. 
 * @param {} chart_id
 * @param {} from
 * @param {} to
 */
function amGetZoom(chart_id, from, to){
}

/**
 * This function is called when the viewer selects the graph by clicking on it or on the graph's legend entry. Index is the sequential number of a graph in your settings, counting from 0. 
 * @param {} chart_id
 * @param {} index
 * @param {} title
 */
function amGraphSelect(chart_id, index, title){
}

/**
 * This function is called when the viewer deselects the graph by clicking on it or on the graph's legend entry. Index is the sequential number of a graph in your settings, counting from 0. 
 * @param {} chart_id
 * @param {} index
 * @param {} title
 */
function amGraphDeselect(chart_id, index, title){
}

/**
 * This function is called when the viewer hides the graph by clicking on the checkbox in the legend. Index is the sequential number of a graph in your settings, counting from 0. 
 * @param {} chart_id
 * @param {} index
 * @param {} title
 */
function amGraphHide(chart_id, index, title){
}

/**
 * This function is called when the viewer moves the mouse over the plot area. It returns the value of the series over which the mouse is currently hovered. 
 * @param {} chart_id
 * @param {} series
 */
function amRolledOverSeries(chart_id, series) {
}

/**
 * This function is called when the viewer clicks somewhere on the plot area. It returns the value of the series over which the mouse hovered when it was clicked. 
 * @param {} chart_id
 * @param {} series
 */
function amClickedOnSeries(chart_id, series) {
}

/*-------------------------pie-------------------------*/
/**
 * This function is called when the viewer clicks on the slice. It returns chart_id, the sequential number of the slice (index), the title, value, percent value, color and description. 
 * @param {} chart_id
 * @param {} index
 * @param {} title
 * @param {} value
 * @param {} percents
 * @param {} color
 * @param {} description
 */
function amSliceClick(chart_id, index, title, value, percents, color, description) {
	var SWFObject = Ext.get(chart_id);
	SWFObject.owner.fireEvent('clickedOnSlice',chart_id, index, title, value, percents, color, description);
}

/**
 * This function is called when the viewer rolls over the slice. It returns chart_id, the sequential number of the slice (index), the title, value, percent value, color and description. 
 * @param {} chart_id
 * @param {} index
 * @param {} title
 * @param {} value
 * @param {} percents
 * @param {} color
 * @param {} description
 */

function amSliceOver(chart_id, index, title, value, percents, color, description) {
}

/**
 * This function is called when the viewer rolls away from the slice. 
 * @param {} chart_id
 */
function amSliceOut(chart_id) {
}
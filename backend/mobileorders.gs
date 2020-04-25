function onOpen() {
  var ui = SpreadsheetApp.getUi();
  ui.createMenu('Glowbom').addItem('Console', 'showConsole').addToUi();
}

function showConsole() {
  SpreadsheetApp.getActiveSpreadsheet().toast('Glowbom Console');
}

function doGet(e) {
  var ss = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1tUnbUF_BVWSbJc7s-b3hOZjl7-vEajOGOHlELFjV-tY/edit#gid=0')
  var sheet = ss.getSheetByName('Products');
  return getTrainings(sheet);
}

function getTrainings(sheet) {
  var jo = {};
  var dataArray = [];
  var rows = sheet.getRange(2, 1, sheet.getLastRow(), sheet.getLastColumn()).getValues();
  
  for (var i = 0, l = rows.length; i < l - 1; i++) {
    var dataRow = rows[i];
    var record = {}
    record['id'] = dataRow[0];
    record['title'] = dataRow[1];
    record['video'] = dataRow[2];
    record['subtitle'] = dataRow[3];
    record['description'] = dataRow[4];
    record['group'] = dataRow[5];
    record['image_url'] = dataRow[6];
    
    dataArray.push(record);
  }
  
  jo.user = dataArray;
  
  var result = JSON.stringify(dataArray);
  
  return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON);
}

function doGet1() {
  return jsonCards();
}

function jsonCards(){
  var dataObj = {};
  dataObj['clients'] = getItems(getData('Trainings'));
  return ContentService.createTextOutput(JSON.stringify(dataObj));
}

function getItems(data){
  var columns = 0;
  while(data[0][columns]){
    columns++;
  }
  var items = [];
  for(var i = 1; i < data.length; i++){
    if(data[i][0] == "") continue;
    var item = {};
    
    items.push(item);
  }
  return items;
}

function getData(sheetName) {
  return SpreadsheetApp
      .openById('1tUnbUF_BVWSbJc7s-b3hOZjl7-vEajOGOHlELFjV-tY')
      .getSheetByName(sheetName)
      .getDataRange()
      .getValues();
}



// ATTENTION!!! CHANGE THE URL TO YOUR SPREADSHEET URL
var YOUR_SPREADSHEET_URL = 'https://docs.google.com/spreadsheets/d/1tUnbUF_BVWSbJc7s-b3hOZjl7-vEajOGOHlELFjV-tY/edit#gid=0';
  
  
 
function onOpen() {
  var ui = SpreadsheetApp.getUi();
  ui.createMenu('Glowbom').addItem('Console', 'showConsole').addToUi();
}

function showConsole() {
  SpreadsheetApp.getActiveSpreadsheet().toast('Glowbom Console');
}

function doGet(e) {
  var ss = SpreadsheetApp.openByUrl(YOUR_SPREADSHEET_URL)
  var sheet = ss.getSheetByName('Products');
  return getProducts(sheet);
}

function getProducts(sheet) {
  var jo = {
    data: []
  };
  
  var rows = sheet.getRange(2, 1, sheet.getLastRow(), sheet.getLastColumn()).getValues();
  
  for (var i = 0, l = rows.length; i < l - 1; i++) {
    var dataRow = rows[i];
    var record = {}
    record['id'] = i.toString();
    record['product'] = dataRow[0];
    record['desciption'] = dataRow[1];
    record['price'] = dataRow[2];
    record['count'] = dataRow[3];
    record['media'] = dataRow[4];
    record['choice1'] = dataRow[5];
    record['choice2'] = dataRow[6];
    record['choice3'] = dataRow[7];
    record['tips'] = dataRow[8];
    record['tax'] = dataRow[9];
    
    jo.data.push(record);
  } 
  
  var result = JSON.stringify(jo);
  
  return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON);
}
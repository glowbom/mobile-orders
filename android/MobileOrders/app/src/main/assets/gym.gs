function onOpen() {
  var ui = SpreadsheetApp.getUi();
  ui.createMenu('Glowbom').addItem('Console', 'showConsole').addToUi();
}

function showConsole() {
  SpreadsheetApp.getActiveSpreadsheet().toast('Glowbom Console');
}

function doGet(e) {
  var ss = SpreadsheetApp.openByUrl('PUT_YOUR_DOCUMENT_URL_HERE')
  var sheet = ss.getSheetByName('Trainings');
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
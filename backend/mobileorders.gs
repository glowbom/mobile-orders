
// ATTENTION!!! CHANGE THE URL TO YOUR SPREADSHEET URL
var YOUR_SPREADSHEET_URL = 'https://docs.google.com/spreadsheets/d/1tUnbUF_BVWSbJc7s-b3hOZjl7-vEajOGOHlELFjV-tY/edit#gid=0';
  


function doGet(e) {
  if (e.parameters.data) {
    var data = e.parameter.data;
    
    var ss = SpreadsheetApp.openByUrl(YOUR_SPREADSHEET_URL);
    var sheet = ss.getSheetByName("Orders");
    
    var order = data.split(',');
    
    if (order.length > 2) {
      var name = order[0];
      var price = order[1];
      
      var prods = getProductList();
    
      var elemens = [
        name,
        price
      ];
      
      for (var i = 2; i < order.length; i++) {
        try {
          elemens.push(prods[parseInt(order[i])].product);
        }
        catch(err) {
          // it's ok to do nothing
        }
      }
    
      sheet.appendRow(elemens);
  
      var result = JSON.stringify({ 
        success: true
      });
  
      return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON);
    } else {
      var result = JSON.stringify({ 
        success: false
      });
  
      return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON);
    }
  } else {
    var ss = SpreadsheetApp.openByUrl(YOUR_SPREADSHEET_URL)
    var sheet = ss.getSheetByName('Products');
    return getProducts(sheet);
  }
}

function getProductList() {
  var ss = SpreadsheetApp.openByUrl(YOUR_SPREADSHEET_URL)
  var sheet = ss.getSheetByName('Products');
  
  var jo = {
    data: []
  };
  
  var rows = sheet.getRange(2, 1, sheet.getLastRow(), sheet.getLastColumn()).getValues();
  
  for (var i = 0, l = rows.length; i < l - 1; i++) {
    var dataRow = rows[i];
    var media = String(dataRow[4]);
    var record = {}
    record['id'] = i.toString();
    record['product'] = dataRow[0];
    record['desciption'] = dataRow[1];
    record['price'] = dataRow[2];
    record['count'] = dataRow[3];
    record['media'] = media;
    
    if (media && media.includes('youtube.com/watch')) {
      media = media.replace('youtube.com/watch?v=', 'youtube.com/embed/');
      if (media.includes('&')) {
        media = media.split('&')[0];
      }
      record['media'] = media;
    }
    
    jo.data.push(record);
  } 
  
  
  return jo.data;
}

function getProducts(sheet) {
  var jo = {
    data: []
  };
  
  var rows = sheet.getRange(2, 1, sheet.getLastRow(), sheet.getLastColumn()).getValues();
  
  for (var i = 0, l = rows.length; i < l - 1; i++) {
    var dataRow = rows[i];
    var media = String(dataRow[4]);
    var record = {}
    record['id'] = i.toString();
    record['product'] = dataRow[0];
    record['desciption'] = dataRow[1];
    record['price'] = dataRow[2];
    record['count'] = dataRow[3];
    record['media'] = media;
    
    if (media && media.includes('youtube.com/watch')) {
      media = media.replace('youtube.com/watch?v=', 'youtube.com/embed/');
      if (media.includes('&')) {
        media = media.split('&')[0];
      }
      record['media'] = media;
    }
    
    //record['choice1'] = dataRow[5];
    //record['choice2'] = dataRow[6];
    //record['choice3'] = dataRow[7];
    //record['tips'] = dataRow[8];
    //record['tax'] = dataRow[9];
    
    jo.data.push(record);
  } 
  
  var result = JSON.stringify(jo);
  
  return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON);
}
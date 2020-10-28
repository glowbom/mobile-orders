## Glowbom Store

Glowbom Store can help you set up a simple store app connected to a Google Sheet. No programming skills required.

[Get Started](https://glowbom.com/store/)

### Create your own store app without code.

Collect orders using a Google Sheet.

[![Here's how it works...](https://glowbom.com/store/img/store1.png)](https://glowbom.com/)

## Step-by-Step Setup Instructions

### Step 1

Open [Glowbom](https://glowbom.com/chat/) and create an account if you haven't done it already.

### Step 2

Press **+ New Project** at the top right corner:

[![Step 2](https://glowbom.com/store/img/qstep1.png)](https://glowbom.com/)

Or press the little mic button and say: **"Create an app."**

[![Step 2](https://glowbom.com/store/img/qstep2.png)](https://glowbom.com/)

### Step 3

Choose **Store** and press **Select**:

[![Step 3](https://glowbom.com/store/img/qstep3.png)](https://glowbom.com/)

Or say: **"Create a store app."**

### Step 4

Enter the project name and press **Create project**:

[![Step 3](https://glowbom.com/store/img/qstep4.png)](https://glowbom.com/)

Or say: **"Create a store app called..."** with the name of your project.

### Step 5

To add and modify products, press the little pencil button:

[![Step 3](https://glowbom.com/store/img/qstep5.png)](https://glowbom.com/)

Or say: **"Open an editor."**

### Step 6

By default, you have 4 products. To add a new product, press the "+" button:

[![Step 3](https://glowbom.com/store/img/qstep6.png)](https://glowbom.com/)

To edit the product, press the little pencil button.

To remove the product, press the remove button.

To close the editor, press the cross button at the top center.

### Step 7

Fill out the title, price, description, and image URL fields to add or edit the product:

[![Picture](https://glowbom.com/store/img/qstep7.png)](https://glowbom.com/)

And press the **"Save"** button.

### Step 8

Press the "Play" button on the top right to run the project:

[![Picture](https://glowbom.com/store/img/qstep10.png)](https://glowbom.com/)

Or say: **"Launch the project please."**

Press the "Stop" button on the top right to stop the project:

[![Picture](https://glowbom.com/store/img/qstep10-2.png)](https://glowbom.com/)

Or say: **"Stop the project please."**

### Step 9

To customize your survey, open the project settings by clicking the small gear button on the bottom left:

[![Picture](https://glowbom.com/store/img/qstep8.png)](https://glowbom.com/)

You can choose your app color, collect name, phone, or shipping address, and also change the "thank you" message:

[![Picture](https://glowbom.com/store/img/qstep8-2.png)](https://glowbom.com/)

To collect orders using a Google Sheet, press the **"Create Form"** button.

### Step 10

Make your own copy of **"Store"** Google Sheet by going to **File->Make a copy**:

[![Picture](https://glowbom.com/store/img/qstep12.png)](https://glowbom.com/)

Open the editor by going to **Tools->Script editor**:

[![Picture](https://glowbom.com/store/img/qstep12-2.png)](https://glowbom.com/)

### Step 11

Clear everything inside the script window:

[![Picture](https://glowbom.com/store/img/qstep12-3.png)](https://glowbom.com/)

Copy a server script:

```
          function doGet(e) {
            if (e.parameters.data) {
              var data = e.parameter.data;
              
              var ss = SpreadsheetApp.getActive();
              var sheet = ss.getSheetByName("Orders");
              
              var responses = data.split(';');
              
              if (responses.length == 5) {
              
                var elemens = [
                  responses[0],
                  responses[1],
                  responses[2],
                  responses[3],
                ];
                  
                var answers = responses[4].split(', ');
                  
                for (var i = 0; i < answers.length; i++) {
                  elemens.push(answers[i]);
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
              var result = JSON.stringify({ 
                  success: false
                });
            
                return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON);
            }
          }
```

## Feedback

If you have any questions or feedback, please let us know **support@glowbom.com**.

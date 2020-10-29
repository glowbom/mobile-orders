## Glowbom Store

Glowbom Store can help you set up a simple store app connected to a Google Sheet. No programming skills required.

[Get Started](https://glowbom.com/)

### Create your own store app without code.

Collect orders using a Google Sheet.

[![Here's how it works...](https://glowbom.com/store/img/store1.png)](https://glowbom.com/)

## Step-by-Step Setup Instructions

### Step 1

Open [**Glowbom**](https://glowbom.com/chat/) and create an account if you haven't done it already.

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

```javascript
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

      var result = JSON.stringify({success: true});

      return ContentService.createTextOutput(result)
          .setMimeType(ContentService.MimeType.JSON);
    } else {
      var result = JSON.stringify({success: false});

      return ContentService.createTextOutput(result)
          .setMimeType(ContentService.MimeType.JSON);
    }
  } else {
    var result = JSON.stringify({success: false});

    return ContentService.createTextOutput(result)
        .setMimeType(ContentService.MimeType.JSON);
  }
}
```

### Step 12

Paste the script code inside the editor and press **Save**:

[![Picture](https://glowbom.com/store/img/qstep12-4.png)](https://glowbom.com/)

Name the project and press **Ok**:

[![Picture](https://glowbom.com/store/img/qstep12-5.png)](https://glowbom.com/)

### Step 13

Publish the script by pressing **Publish->Deploy as web app...**:

[![Picture](https://glowbom.com/store/img/qstep13.png)](https://glowbom.com/)

Choose **Anyone, even anonymous** in **Who has access to the app** and press **Deploy**:

[![Picture](https://glowbom.com/store/img/qstep13-2.png)](https://glowbom.com/)

Press **Review Permissions**:

[![Picture](https://glowbom.com/store/img/qstep13-3.png)](https://glowbom.com/)

Press **Allow**:

[![Picture](https://glowbom.com/store/img/qstep13-4.png)](https://glowbom.com/)

Copy **Current web app URL**:

[![Picture](https://glowbom.com/store/img/qstep13-5.png)](https://glowbom.com/)

### Step 14

Paste the **Current web app URL** into **Orders form link**:

[![Picture](https://glowbom.com/store/img/qstep14.png)](https://glowbom.com/)

Run the project again and submit the shipping information:

[![Picture](https://glowbom.com/store/img/qstep14-2.png)](https://glowbom.com/)

The shipping information should appear in the Google Sheet:

[![Picture](https://glowbom.com/store/img/qstep14-3.png)](https://glowbom.com/)

### Step 15

Press the **"Export"** button on the bottom right to export the **store.glowbom** project file and the source code:

[![Picture](https://glowbom.com/store/img/qstep9.png)](https://glowbom.com/)

Or say: **"Export code please."**

### Step 16

You download the data file **store.glowbom** and an archive that has two folders **store-build-web** and **store-source-flutter**:

[![Picture](https://glowbom.com/store/img/qstep11.png)](https://glowbom.com/)

The **store-build-web** folder contains a ready-to-deploy web app.

The **store-source-flutter** folder contains the app source code that can be compiled to iOS, Android, and a web app.

Replace the **store-build-web/assets/assets/store.glowbom** file with your **store.glowbom** file:

[![Picture](https://glowbom.com/store/img/qstep11-2.png)](https://glowbom.com/)

Replace the **store-source-flutter/app/assets/store.glowbom** file with your **store.glowbom** file:

[![Picture](https://glowbom.com/store/img/qstep11-3.png)](https://glowbom.com/)

### Step 17

The **store-build-web** folder contains a ready-to-deploy web app that can be deployed to any hosting.

We recommend using [**Netlify**](https://www.netlify.com/products/edge/) where you can drag & drop **store-build-web** folder to dashboard. The web app will be deployed and the domain will be given to you. Optionally, the web app can be connected with the custom domain/subdomain.

Create an account on [**Netlify**](https://www.netlify.com/products/edge/) to get started.

### Mobile Apps

The **store-source-flutter** folder contains app source code that can be compiled to **iOS**, **Android**, and a web app.

To compile the source code, you need to install [**Flutter**](https://flutter.dev/), a software development kit created by Google.

Open [**Flutter**](https://flutter.dev/).

## Feedback

If you have any questions or feedback, please let us know **support@glowbom.com**.

### How to contribute

Everyone is welcome to contribute to **Glowbom Store**. There are several ways of getting involved and contributing including pull requests, reporting bugs, improving documentation and tutorials.

### Upcoming Features

Stripe payments,
Paypal payments,
Airtable support,
Multiple layouts support,
Localization,
Categories support,
Search,
Saving past orders,
Notifications,
Analytics,
Multiple exporting options.

Please file feature requests and bugs at the [issue tracker](https://github.com/Glowbom/mobile-orders/issues).

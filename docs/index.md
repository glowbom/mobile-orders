## Glowbom Store

**Glowbom Store** can help you set up a simple e-commerce app connected to a Google Sheet. No programming skills required.

[Get Started](https://glowbom.com/)

### Create your own store without code.

Use Google Sheets to collect orders.

[![Here's how it works...](https://user-images.githubusercontent.com/2455891/97621854-11b3c300-19e9-11eb-93ba-c9a3fc7f7cdf.png)](https://glowbom.com/)

## Step-by-Step Setup Instructions

### Step 1

Open [**Glowbom**](https://glowbom.com/chat/) and create an account if you haven't done it already. It's free and takes 30 seconds.

### Step 2

Press **+ New Project** at the top right corner:

[![Step 2](https://user-images.githubusercontent.com/2455891/97621818-0c567880-19e9-11eb-93ba-6a8d9944c7b8.png)](https://glowbom.com/)

Or press the little mic button and say: **"Create an app."**

[![Step 2](https://user-images.githubusercontent.com/2455891/97621819-0cef0f00-19e9-11eb-984a-41e89a44490f.png)](https://glowbom.com/)

### Step 3

Choose **Store** and press **Select**:

[![Step 3](https://user-images.githubusercontent.com/2455891/97621820-0cef0f00-19e9-11eb-83c5-ee3c00823845.png)](https://glowbom.com/)

Or say: **"Create a store app."**

### Step 4

Enter the project name and press **Create project**:

[![Step 3](https://user-images.githubusercontent.com/2455891/97621821-0cef0f00-19e9-11eb-8e87-83d8e0976cf0.png)](https://glowbom.com/)

Or say: **"Create a store app called..."** with the name of your project.

### Step 5

To add and modify products, press the little pencil button:

[![Step 3](https://user-images.githubusercontent.com/2455891/97621823-0d87a580-19e9-11eb-82b2-20a615e91a3b.png)](https://glowbom.com/)

Or say: **"Open an editor."**

### Step 6

By default, you have 4 products. To add a new product, press the "+" button:

[![Step 3](https://user-images.githubusercontent.com/2455891/97621824-0d87a580-19e9-11eb-8c8a-3086ab168a64.png)](https://glowbom.com/)

To edit the product, press the little pencil button.

To remove the product, press the remove button.

To close the editor, press the cross button at the top center.

### Step 7

Fill out the title, price, description, and image URL fields to add or edit the product:

[![Picture](https://user-images.githubusercontent.com/2455891/97621825-0d87a580-19e9-11eb-91c3-3d37c8e70da4.png)](https://glowbom.com/)

And press the **"Save"** button.

### Step 8

Press the "Play" button on the top right to run the project:

[![Picture](https://user-images.githubusercontent.com/2455891/97621829-0eb8d280-19e9-11eb-9a0b-c3df20755125.png)](https://glowbom.com/)

Or say: **"Launch the project please."**

Press the "Stop" button on the top right to stop the project:

[![Picture](https://user-images.githubusercontent.com/2455891/97621831-0eb8d280-19e9-11eb-997a-4ad191719f77.png)](https://glowbom.com/)

Or say: **"Stop the project please."**

### Step 9

To customize your survey, open the project settings by clicking the small gear button on the bottom left:

[![Picture](https://user-images.githubusercontent.com/2455891/97621826-0e203c00-19e9-11eb-8029-5f48b780da0a.png)](https://glowbom.com/)

You can choose your app color, collect name, phone, or shipping address, and also change the "thank you" message:

[![Picture](https://user-images.githubusercontent.com/2455891/97621827-0e203c00-19e9-11eb-95a0-0e50965d91d7.png)](https://glowbom.com/)

To collect orders using a Google Sheet, press the **"Create Form"** button.

### Step 10

Make your own copy of **"Store"** Google Sheet by going to **File->Make a copy**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621841-10829600-19e9-11eb-8a2f-d8687c3a8f55.png)](https://glowbom.com/)

Open the editor by going to **Tools->Script editor**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621837-0fe9ff80-19e9-11eb-8632-f00636747062.png)](https://glowbom.com/)

### Step 11

Clear everything inside the script window:

[![Picture](https://user-images.githubusercontent.com/2455891/97621838-0fe9ff80-19e9-11eb-8a7d-32d045a1e047.png)](https://glowbom.com/)

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

[![Picture](https://user-images.githubusercontent.com/2455891/97621839-0fe9ff80-19e9-11eb-8cf8-7de283c0e153.png)](https://glowbom.com/)

Name the project and press **Ok**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621840-10829600-19e9-11eb-979e-c37e32a5806c.png)](https://glowbom.com/)

### Step 13

Publish the script by pressing **Publish->Deploy as web app...**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621842-10829600-19e9-11eb-8976-0942660be90a.png)](https://glowbom.com/)

Choose **Anyone, even anonymous** in **Who has access to the app** and press **Deploy**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621843-10829600-19e9-11eb-875b-3f5fca1c72e9.png)](https://glowbom.com/)

Press **Review Permissions**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621846-111b2c80-19e9-11eb-9354-ec61c1b0b96d.png)](https://glowbom.com/)

Press **Allow**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621847-111b2c80-19e9-11eb-8d36-f4e4c00770ce.png)](https://glowbom.com/)

Copy **Current web app URL**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621849-111b2c80-19e9-11eb-9803-7564770fb084.png)](https://glowbom.com/)

### Step 14

Paste the **Current web app URL** into **Orders form link**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621850-11b3c300-19e9-11eb-8dfb-0ec8af7f9a53.png)](https://glowbom.com/)

Run the project again and submit the shipping information:

[![Picture](https://user-images.githubusercontent.com/2455891/97621851-11b3c300-19e9-11eb-806c-dd314093441a.png)](https://glowbom.com/)

The shipping information should appear in the Google Sheet:

[![Picture](https://user-images.githubusercontent.com/2455891/97621852-11b3c300-19e9-11eb-9015-fe1b3e4da6c2.png)](https://glowbom.com/)

### Step 15

Press the **"Export"** button on the bottom right to export the **store.glowbom** project file and the source code:

[![Picture](https://user-images.githubusercontent.com/2455891/97621828-0e203c00-19e9-11eb-862a-5c299793932f.png)](https://glowbom.com/)

Or say: **"Export code please."**

### Step 16

You download the data file **store.glowbom** and an archive that has two folders **store-build-web** and **store-source-flutter**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621832-0f516900-19e9-11eb-8e75-3bc5848e8521.png)](https://glowbom.com/)

The **store-build-web** folder contains a ready-to-deploy web app.

The **store-source-flutter** folder contains the app source code that can be compiled to iOS, Android, and a web app.

Replace the **store-build-web/assets/assets/store.glowbom** file with your **store.glowbom** file:

[![Picture](https://user-images.githubusercontent.com/2455891/97621833-0f516900-19e9-11eb-876e-a98b0d7531e0.png)](https://glowbom.com/)

Replace the **store-source-flutter/app/assets/store.glowbom** file with your **store.glowbom** file:

[![Picture](https://user-images.githubusercontent.com/2455891/97621835-0f516900-19e9-11eb-9488-a05062f45a24.png)](https://glowbom.com/)

### Step 17

The **store-build-web** folder contains a ready-to-deploy web app that can be deployed to any hosting.

We recommend using [**Netlify**](https://www.netlify.com/products/edge/) to publish the web app. It allows you to drag & drop the web app folder directly to the dashboard. The web app deploys automatically, and you will get the app link shortly after that. Optionally, you will be able to connect the web app with the custom domain or subdomain.

Create an account on [**Netlify**](https://www.netlify.com/products/edge/) to get started.

### Mobile Apps

To build the app for **iOS** or **Android**, you need to install [**Flutter**](https://flutter.dev/docs/get-started/install), a software development kit created by **Google**. The **store-source-flutter** folder contains the **Flutter** project that can be compiled to **iOS**, **Android**, and a web app.

## Feedback

If you have any questions or feedback, please let us know **support@glowbom.com**.

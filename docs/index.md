## Glowbom Store

**Glowbom Store** can help you set up a simple e-commerce flutter app connected to a Google Sheet. No programming skills required.

[**Get Started**](https://glowbom.com/)

### Create your own store without learning how to code.

Use Google Sheets to collect orders.

Use PayPal to collect payments.



[![Here's how it works...](https://user-images.githubusercontent.com/2455891/97621854-11b3c300-19e9-11eb-93ba-c9a3fc7f7cdf.png)](https://glowbom.com/)

### About Glowbom

**Glowbom** is the first no-code platform that lets you create flutter apps via chat, using just your voice.

### Here's how it works...

[![Here's how it works...](https://user-images.githubusercontent.com/2455891/93039674-5637fa80-f605-11ea-98fd-f1f280e83904.png)](https://www.youtube.com/watch?v=gDNHy0em7Do)

## Step-by-Step Store Setup Instructions

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

To customize your store, open the project settings by clicking the small gear button on the bottom left:

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

[![Picture](https://user-images.githubusercontent.com/2455891/132927570-064f2413-56dd-4f1c-afb8-0578bbd9824d.png)](https://glowbom.com/)

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

[![Picture](https://user-images.githubusercontent.com/2455891/132927719-3c05736c-8363-48ca-a22e-0ce479c641c0.png)](https://glowbom.com/)

Name the project and press **Rename**:

[![Picture](https://user-images.githubusercontent.com/2455891/132927792-de66c6af-5756-450d-a394-9866d067171f.png)](https://glowbom.com/)

### Step 13

Publish the script by pressing **Deploy->New deployment**:

[![Picture](https://user-images.githubusercontent.com/2455891/132927854-d33697ef-05d2-4134-a46f-8a7d5e493683.png)](https://glowbom.com/)

Choose **Web app** as a deployment type:

[![Picture](https://user-images.githubusercontent.com/2455891/132928025-70efd3cf-0257-44cb-a09e-50c04e6380b7.png)](https://glowbom.com/)

Choose **Anyone** from **Who has access**:

[![Picture](https://user-images.githubusercontent.com/2455891/132928364-5ad93242-b885-463f-abf6-313b903f6e12.png)](https://glowbom.com/)

Press **Authorize access** and grant permissions:

[![Picture](https://user-images.githubusercontent.com/2455891/132928443-febf547e-2207-49bc-8478-13b7407a1d4c.png)](https://glowbom.com/)

Copy **Web app URL**:

[![Picture](https://user-images.githubusercontent.com/2455891/132928561-632191ec-5502-445f-a2d5-f727a63d4f13.png)](https://glowbom.com/)

### Step 14

Paste the **Web app URL** into **Orders form link**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621850-11b3c300-19e9-11eb-8dfb-0ec8af7f9a53.png)](https://glowbom.com/)

Run the project again and submit the shipping information:

[![Picture](https://user-images.githubusercontent.com/2455891/97621851-11b3c300-19e9-11eb-806c-dd314093441a.png)](https://glowbom.com/)

The shipping information should appear in the Google Sheet:

[![Picture](https://user-images.githubusercontent.com/2455891/97621852-11b3c300-19e9-11eb-9015-fe1b3e4da6c2.png)](https://glowbom.com/)

### Collecting Payments with PayPal

Create the [**PayPal.Me**](https://www.paypal.com/paypalme/) link and paste it into **PayPal.me link** to collect payments using PayPal:

[![Picture](https://user-images.githubusercontent.com/2455891/98414923-77332f80-2039-11eb-9674-311c309d6b51.png)](https://glowbom.com/)

### Next Steps

[Publish your app](https://glowbom.github.io/Glowbom/Publish){:target="_blank" rel="noopener"}

### GPT-3 product description generation

You can also use **GPT-3** to generate a selling product description if you have an **OpenAI** account. Here's [how it works](http://www.youtube.com/watch?v=ejz8TByCleg&t=5m56s){:target="_blank" rel="noopener"}.

## Feedback

If you have any questions or feedback, please let us know **support@glowbom.com**.

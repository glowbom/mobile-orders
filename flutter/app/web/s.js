function s(message) {
  if ('speechSynthesis' in window) {
    console.log('speaking...');
    var msg = new SpeechSynthesisUtterance();
    msg.text = message;
    window.speechSynthesis.speak(msg);
    console.log('spoke ' + message);
  } else {
    // Speech Synthesis Not Supported 😣
    alert("Sorry, your browser doesn't support text to speech!");
  }

}
export default {
  mounted() {
    console.log("----------------------------------------")
    console.log("Speak hook mounted")
    console.log("----------------------------------------")
    this.handleEvent("Voice", ({ text, lang }) => {
      const utterance = new SpeechSynthesisUtterance(text)
      utterance.lang = lang || "es-ES" // default to Spanish
      speechSynthesis.speak(utterance)
    })
  }
}
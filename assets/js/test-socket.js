import {Socket} from "phoenix"

let socket = new Socket("/socket", {})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("firehose:all", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

const debug = document.getElementById("debug")
channel.on("log", payload => {
  if (debug) {
    debug.innerText += JSON.stringify(payload) + "\n";
  }
})
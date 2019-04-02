import {Socket} from "phoenix"
import renderHangman from "./hangman_component"

export default class HangmanSocket {
  constructor() {
    this.new_game = this.new_game.bind(this)
    this.make_move = this.make_move.bind(this)
    this.socket = new Socket("/socket", {})
    this.socket.connect();
  }

  connect_to_hangman() {
    this.setup_channel()

    this.channel.on("tally", tally => {
      // render our game
      renderHangman(tally, this.new_game, this.make_move)
    })
  }  

  setup_channel() {
    this.channel = this.socket.channel("hangman:game", {})
    this.channel
      .join()
      .receive("ok", resp => {
        this.fetch_tally()
      })
      .receive("error", resp => {
        alert(resp)
        throw(resp)
      })
  }

  new_game() {
    this.channel.push("new_game", {})
  }
  
  fetch_tally() {
    this.channel.push("tally", {})
  }

  make_move(guess) {
    this.channel.push("make_move", guess)
  }
}
import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import gallows from './gallows'

let turn = (left, num) => {
  if(left >= num) return "opacity: 0.1"
  else return "opacity: 0"
}

const responses = {
  won: ['success', "You Won!"],
  lost: ['danger', "You Lost!"],
  good_guess: ['info', "Good guess!"],
  bad_guess: ['warning', "Bad guess!"],
  invalid_guess: ['warning', "Please guess single lowercase letters"],
  already_used: ['warning', "You already guessed that"],
  initializing: [null, null]
}

function HangmanComponent(props) {
  const { tally, new_game, make_move } = props.hangman
  const game_over = ["won", "lost"].includes(tally.game_state)
  const [guess, setGuess] = useState("")
  const make_move_and_clear_guess = () => {
    make_move(guess)
    setGuess("")
  }

  return (
    <div>
      <div style={{textAlign: 'center'}}>
        <h1>Hangman</h1>
        <span className={`badge badge-${responses[tally.game_state][0]}`}>{responses[tally.game_state][1]}</span>        
      </div>
      <div style={{display: 'flex', flexDirection: 'row', justifyContent: 'space-around'}}>
        <div>
        </div>
        <div style={{width: '300px'}}>
          <p>Turns left: {tally.turns_left}</p>
          <p>Letters used: {tally.used}</p>
          <p>Word so far: {tally.letters.join(" ")}</p>
          
          { game_over ?
            <div>
              <p>The word was: <b>{tally.word}</b></p>
              <button onclick={new_game}>New Game</button>
            </div>            
          : 
            <div>
              <input 
                type="text" 
                name="guess" 
                value={guess} 
                onChange={e => setGuess(e.target.value.slice(0, 1))} 
                onKeyDown={e => e.key === 'Enter' ? make_move_and_clear_guess() : null}
                autoFocus/>
              <input type="button" value="Make Move" onClick={make_move_and_clear_guess}/>
            </div>
          }
        </div>
      </div>
    </div>
  )
}

let renderHangman = (tally, new_game, make_move) => {
  let app_root = document.getElementById("app_root")
  ReactDOM.render(<HangmanComponent hangman={{tally, new_game, make_move}}/>, app_root)
}

export default renderHangman
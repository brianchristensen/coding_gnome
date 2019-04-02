import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import Gallows from './gallows'

const responses = {
  won: ['success', 'You Won!'],
  lost: ['danger', 'You Lost!'],
  good_guess: ['info', 'Good guess!'],
  bad_guess: ['warning', 'Bad guess!'],
  invalid_guess: ['warning', 'Please guess single lowercase letters'],
  already_used: ['warning', 'You already guessed that'],
  initializing: ['init', `Don't get hung!`]
}

function HangmanComponent(props) {
  const { tally, new_game, make_move } = props.hangman
  const game_over = ["won", "lost"].includes(tally.game_state)
  const [guess, setGuess] = useState("")

  const make_move_and_clear_guess = () => {
    make_move(guess)
    setGuess("")
  }

  const alert_style = responses[tally.game_state][0]
  const alert_msg = responses[tally.game_state][1]
  
  return (
    <div>
      <div style={{textAlign: 'center'}}>
        <h1>Hangman</h1>
        <div className={`alert alert-${alert_style}`}>{alert_msg}</div>        
      </div>
      <div style={{display: 'flex', flexDirection: 'row', justifyContent: 'space-around'}}>
        <div>
          <Gallows turns_left={tally.turns_left}/>
        </div>
        <div style={{width: '300px'}}>
          <p>Turns left: {tally.turns_left}</p>
          <p>Letters used: {tally.used}</p>
          <p>Word so far: {tally.letters.join(" ")}</p>
          
          { game_over ?
            <div>
              <p>The word was: <b>{tally.word}</b></p>
              <button onClick={new_game} autoFocus>New Game</button>
            </div>            
          : 
            <div>
              <input 
                type="text" 
                name="guess" 
                value={guess} 
                onChange={e => setGuess(e.target.value.slice(0, 1))} 
                onKeyDown={e => e.key === 'Enter' ? make_move_and_clear_guess() : null}
                autoComplete="off"
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
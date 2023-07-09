// add in word list selector (verbs, words, sentences, etc.)

import "./App.css";
import React, { useState, useEffect } from "react";
import RandomWordList from "./components/Randomizer.js";
import classNames from "classnames";

function App() {
  // Properties
  const [showResults, setShowResults] = useState(false);
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [score, setScore] = useState(0);
  const [isActive, setIsActive] = useState(false);
  const [selectedOption, setSelectedOption] = useState(null);

  // Helper functions
  const handleClick = () => {
    setIsActive(true);
  };

  const handleAnswer = (isCorrect, optionId) => {
    if (isCorrect) {
      setScore((prevScore) => prevScore + 1);
    }
    setSelectedOption(optionId);
    // Wait for 1 second
    setTimeout(() => {
      if (currentQuestion + 1 < RandomWordList.length) {
        setCurrentQuestion(currentQuestion + 1);
      } else {
        setShowResults(true);
      }
      setSelectedOption(null);
      setIsActive(false);
    }, 1000);
  };

  const restartGame = () => {
    setScore(0);
    setCurrentQuestion(0);
    setShowResults(false);
  };

  // Reset selectedOption and isActive state
  useEffect(() => {
    if (selectedOption !== null) {
      setTimeout(() => {
        setSelectedOption(null);
        setIsActive(false);
      }, 1000);
    }
  }, [selectedOption]);

  return (
    <div className="App">
      <header>
        <h1>Danish | English Quiz</h1>
      </header>
      {showResults ? (
        <div className="final-results">
          <h1>Final Results</h1>
          <h2>
            {score} out of {RandomWordList.length} correct - (
            {((score / RandomWordList.length) * 100).toFixed(1)}
            %)
          </h2>
          <button onClick={() => restartGame()}>Restart game</button>
        </div>
      ) : (
        <div className="question-card">
          <h2>
            Question: {currentQuestion + 1} out of {RandomWordList.length}
          </h2>
          <h3 className={classNames("question-text")}>
            {RandomWordList[currentQuestion].text}
          </h3>
          <ul>
            {RandomWordList[currentQuestion].options.map((option) => {
              const classes = classNames({
                "selected-option": option.id === selectedOption,
                "correct-option": isActive && option.isCorrect,
                "incorrect-option": isActive && !option.isCorrect,
              });
              return (
                <li
                  key={option.id}
                  className={classes}
                  onClick={() => {
                    handleAnswer(option.isCorrect, option.id);
                    handleClick();
                  }}
                >
                  {option.text}
                </li>
              );
            })}
          </ul>
          <h2>Score: {score}</h2>
        </div>
      )}
    </div>
  );
}

export default App;

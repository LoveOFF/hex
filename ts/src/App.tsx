import * as React from 'react';
import { Component } from 'react';
import './App.css';
import { hex } from './hex/main';

const logo = require('./logo.svg');

class App extends Component {

  async binToHex() {
    // TODO: Promisify XMLHttpRequest
    // https://stackoverflow.com/questions/30008114/how-do-i-promisify-native-xhr
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'fake_item_file.bin', true);
    xhr.responseType = 'blob';
    xhr.onload = async function() {
      var blob = xhr.response;
      let arrayBuffer = await hex.readAsArrayBuffer(blob);
      var uint8Array = new Uint8Array(arrayBuffer);

      let hexResult = '';
      uint8Array.forEach(param => {
        hexResult += param.toString(16);
      });
      console.log('hex result: ', hexResult);
     // .toString(16); // int -> hex
     // parseInt(hexString, 16); // hex -> int
    };
    xhr.send();
  }

  render() {
    this.binToHex();
    let output = hex.add(1, 2);
    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to React</h2>
        </div>
        <p className="App-intro">
          To get started, edit <code>src/App.tsx</code> and save to reload.
        </p>
        <p className="output">
        {output}
        </p>
      </div>
    );
  }
}

export default App;

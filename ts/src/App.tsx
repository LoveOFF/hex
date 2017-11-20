import * as React from 'react';
import { Component } from 'react';
import './App.css';
import { hex } from './hex/main';

const logo = require('./logo.svg');

interface State {
  data: string;
}

interface Props {
}

class App extends Component<Props, State> {

  constructor(props: Props) {
    super(props);

    this.state = {
      data: ''
    };
  }

  async componentDidMount() {
    // XHR in jsdom = crash
    if (!navigator.userAgent.includes("Node.js")) {
      let output = await hex.loadDefaultSaveAsHex();
      this.setState({ data: output});
    }
  }

  render() {
    let data = '';

    if (this.state && this.state.data) {
      data = this.state.data;
    }

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
        {data}
        </p>
      </div>
    );
  }
}

export default App;

import * as React from 'react';
import { Component } from 'react';
import './App.css';
import { hex } from './hex/main';

const logo = require('./logo.svg');

interface State {
  items: Array<string>;
}

interface Props {
}

class App extends Component<Props, State> {

  constructor(props: Props) {
    super(props);

    this.state = {
      items: []
    };
  }

  async componentDidMount() {
    // XHR in jsdom = crash
    if (!navigator.userAgent.includes('Node.js')) {
      let output = await hex.loadDefaultSaveAsHex();
      let items = hex.parseItems(output);
      this.setState({ items: items });
    }
  }

  render() {
    let items: Array<string> = [];

    if (this.state && this.state.items) {
      items = this.state.items;
    }

    // todo: render the items better
    // https://reactjs.org/docs/lists-and-keys.html#keys
    // https://stackoverflow.com/questions/35351706/how-to-render-a-multi-line-text-string-in-react

    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to React</h2>
        </div>
        <p className="App-intro">
          To get started, edit <code>src/App.tsx</code> and save to reload.
        </p>
        <div className="output">
        {
          items.map((item, index) => {
            return <div key={index}>{item}</div>;
          })
        }
        </div>
      </div>
    );
  }
}

export default App;

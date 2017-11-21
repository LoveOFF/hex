import * as React from 'react';
import { Component } from 'react';
import './App.css';
// import { hex } from './hex/main';

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

  // TODO: set state once file is uploaded / drag & dropped.
  setupDragAndDropUpload() {
    // https://www.html5rocks.com/en/tutorials/file/dndfiles/
    var dragover = function(event: DragEvent) {
      event.stopPropagation();
      event.preventDefault();
      // https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer/dropEffect
      event.dataTransfer.dropEffect = 'copy';
    };

    var drop = function(event: DragEvent) {
      event.stopPropagation();
      event.preventDefault();
      let files = event.dataTransfer.files;

      if (files.length > 0) {
        console.log('dropped: ' + files[0].name);
      }
    };

    var fileSelected = function(event: Event ) {
      let files = (event.target as HTMLInputElement).files;
      if (files !== null && files.length > 0) {
        console.log('uploaded: ' + files[0].name);
      }
    };

    var click = function(event: MouseEvent) {
      let input = document.getElementById('uploadInput');
      if (input !== null) { input.click(); }
    };

    let uploadElement = document.getElementById('uploadDiv');
    if (uploadElement !== null) {
      console.log('added event lister');
      uploadElement.addEventListener('dragover', dragover, false);
      uploadElement.addEventListener('drop', drop, false);
      uploadElement.addEventListener('click', click, false);
    }

    let uploadInput = document.getElementById('uploadInput');
    if (uploadInput !== null) {
      uploadInput.addEventListener('change', fileSelected, false);
    }
  }

  async componentDidMount() {
    // XHR in jsdom = crash
    // if (!navigator.userAgent.includes('Node.js')) {
    //   let output = await hex.loadDefaultSaveAsHex();
    //   let items = hex.parseItems(output);
    //   this.setState({ items: items });
    // }

    this.setupDragAndDropUpload();
  }

  render() {
    // let items: Array<string> = [];

    // if (this.state && this.state.items) {
    //   items = this.state.items;
    // }

    // todo: render the items better
    // https://reactjs.org/docs/lists-and-keys.html#keys
    // https://stackoverflow.com/questions/35351706/how-to-render-a-multi-line-text-string-in-react

    // {
    //   items.map((item, index) => {
    //     return <div key={index}>{item}</div>;
    //   })
    // }

    let uploadStyle = {
      cursor: 'pointer',
      margin: '0em 1em 0em 1em',
      padding: '16px',
      border: '0.3em dashed #cccccc'
    };

    let inputStyle = {
      opacity: 0,
      position: 'absolute',
      top: 0,
      right: 0,
      fontSize: 0,
      width: 0,
      height: 0
    };

    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to React</h2>
        </div>
        <p className="App-intro">
          To get started, edit <code>src/App.tsx</code> and save to reload.
        </p>
        <div style={uploadStyle} id="uploadDiv">
         <input style={inputStyle as {}} type="file" id="uploadInput" />
         <div><strong>Upload file</strong></div>
         <div>Click here or drag & drop</div>
        </div>
        <div className="output" />
      </div>
    );
  }
}

export default App;

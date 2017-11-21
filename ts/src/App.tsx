import * as React from 'react';
import { Component } from 'react';
import './App.css';
import { hex } from './hex/main';

const logo = require('./logo.svg');

interface State {
  saveName: string;
  output: string;
}

interface Props {
}

class App extends Component<Props, State> {
  hexString: string;
  hexBinary: Blob | null;

  constructor(props: Props) {
    super(props);

    this.state = {
      saveName: '',
      output: ''
    };

    this.hexBinary = null;
    this.hexString = '';
  }

  setupDragAndDropUpload() {
    // https://www.html5rocks.com/en/tutorials/file/dndfiles/
    var dragover = function(event: DragEvent) {
      event.stopPropagation();
      event.preventDefault();
      // https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer/dropEffect
      event.dataTransfer.dropEffect = 'copy';
    };

    var that = this;
    var updateState = function(files: FileList | null) {
      if (files !== null && files.length > 0) {
        // Update hexBinary before setState triggers componentDidUpdate.
        that.hexBinary = files[0];

        that.setState({ 
          saveName: files[0].name
         });
      } 
    };

    var drop = function(event: DragEvent) {
      event.stopPropagation();
      event.preventDefault();
      updateState(event.dataTransfer.files);
    };

    var fileSelected = function(event: Event ) {
      let files = (event.target as HTMLInputElement).files;
      updateState(files);
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
    this.setupDragAndDropUpload();
  }

  async componentDidUpdate(prevProps: Props, prevState: State) {
    console.log('componentDidUpdate', prevProps, prevState);
    if (this.hexBinary !== null) {
      this.hexString = await hex.blobToHexStr(this.hexBinary);
      this.hexBinary = null;
      let items = await hex.parseItems(this.hexString);
      this.setState({output: items.join('\n') });
    }
  }

  render() {
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

    let outputStyle = {
      whiteSpace: 'pre'
    };

    let hasSaveName = this.state.saveName !== '';

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
         <div id="saveName">
         <div><strong>{hasSaveName ? this.state.saveName : 'Upload Save'}</strong></div>
         <div>{hasSaveName ? '' : 'Click here or drag & drop'}</div>
         </div>
        </div>
        <div style={outputStyle} className="output">{this.state.output}</div>
      </div>
    );
  }
}

export default App;

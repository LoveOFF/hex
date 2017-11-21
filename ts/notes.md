// .toString(16); // int -> hex
// parseInt(hexString, 16); // hex -> int


// XHR in jsdom = crash
    // if (!navigator.userAgent.includes('Node.js')) {
    //   let output = await hex.loadDefaultSaveAsHex();
    //   let items = hex.parseItems(output);
    //   this.setState({ items: items });
    // }
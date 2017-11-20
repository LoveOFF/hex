import { StringScanner } from '../strscan/strscan';

export namespace hex {
  export function add(one: number, two: number): number {
    return one + two;
  }
    
  // readAsArrayBuffer is async.
  // https://developer.mozilla.org/en-US/docs/Web/API/FileReader/readAsArrayBuffer
  export async function readAsArrayBuffer(blob: Blob): Promise<ArrayBuffer> {
    return new Promise<ArrayBuffer>((resolve, reject) => {
      let fileReader = new FileReader();
      fileReader.addEventListener('load',  e => resolve((<FileReader> e.target).result));
      fileReader.addEventListener('error', e => reject((<FileReader> e.target).error));
      fileReader.addEventListener('abort', e => reject(new Error('readAsArrayBuffer aborted')));
      fileReader.readAsArrayBuffer(blob);
    });
  }

  export async function loadDefaultSaveAsHex(): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      // Promisify XMLHttpRequest
      // https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
      var xhr = new XMLHttpRequest();
      xhr.open('GET', 'v1.18.save', true);
      xhr.responseType = 'blob';
      xhr.addEventListener('load', async e => {
        let target = <XMLHttpRequest> e.target;
        if (target.status !== 200) {
          return reject({ status: target.status, statusText: target.statusText });
        }

        var blob = target.response;
        let arrayBuffer = await hex.readAsArrayBuffer(blob);
        var uint8Array = new Uint8Array(arrayBuffer);

        let hexResult = '';
        uint8Array.forEach(param => {
          // encode 0 as 00
          let byte = param.toString(16);
          if (byte.length === 1) { byte = '0' + byte; }
          hexResult += byte;
        });

        resolve(hexResult);
      });

      xhr.addEventListener('error', e => {
        let target = <XMLHttpRequest> e.target;
        reject({ status: target.status, statusText: target.statusText });
      });
      xhr.addEventListener('abort', () => reject(new Error('loadDefaultSaveAsHex hxr aborted')));
      
      xhr.send();
    });
  }
  
  export function parseItems(hexString: string): Array<string> {
    let s = new StringScanner(hexString);
    let inventoryStartPattern = 'B2 69 26 91 0C 12 87 31 40 00 00 00';
    let itemPattern = 'D8 A2 61 2D 78 20 C8 3E .. .. .. .. .. .. 00 00';
    s.scan_until(inventoryStartPattern);

    let item;
    let items = [];
    while ((item = s.scan(itemPattern)) !== null) {
      if (typeof item === 'string') { items.push(item); }
    }

    return items;
  }
}

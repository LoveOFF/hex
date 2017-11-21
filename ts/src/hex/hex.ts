import { StringScanner } from '../strscan/strscan';
import { codes } from './codes';

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

  function trimHex(str: string): string {
    return str.replace(/ /g, '').toLowerCase();
  }
  
  function sectionName(sectionIndex: number): string {
    switch (sectionIndex) {
      case 0:
        return 'Battle Items [0]'; // information_battle_item
      case 1:
        return 'Key Items [1]'; // information_event_item
      case 2:
        return 'Ingredients [2]'; // information_food_item
      case 3:
        return 'Treasures [3]'; // information_treasure_item
      case 4:
        return 'Car Parts [4]'; // information_car_item
      case 5:
        return 'Leisure Items [5]'; // information_leisure_item
      case 7: // 6 doesn't exist.
        return 'Reinforcement Items [7]'; // information_reinforcement_item
      case 8:
        return 'Magic Bottle [8]'; // information_magic_bottle
      case 9:
        return 'Ring [9]'; // information_ring_amount
      case 10:
        return 'Weapons [10]'; // information_weapon
      case 11:
        return 'Phantom Swords [11]'; // information_phantom_sword
      case 12:
        return 'Accessories [12]'; // information_accessory
      case 13:
        return 'Cloth [13]'; // information_accessory
      case 14:
        return 'Job Commands [14]'; // information_job_command
      case 15:
        return 'Recipe [15]'; // information_recipe
      default:
        return 'Unknown' + ' [' + sectionIndex + ']';
    }
  }

  // convert little edian to big endian
  function reverseHex(hexString: string): string {
    if (hexString.length < 2) { throw new Error('hex length < 2 ' + hexString); }
    return hexString.match(/.{2}/g)!!.reverse().join(''); 
  }

  export function parseItems(hexString: string): Array<string> {
    let s = new StringScanner(hexString);
    let inventoryStartPattern = 'B2 69 26 91 0C 12 87 31 40 00 00 00';
    // item code: FF FF FF FF, quantity: FF FF
    let itemPattern = 'D8 A2 61 2D 78 20 C8 3E (.. .. .. ..) (.. ..) 00 00';
    s.scan_until(inventoryStartPattern);
    let itemPattern8Bytes = trimHex('D8 A2 61 2D');

    let foundItem;
    let items = [];
    let empty = '00000000';
    let sectionIndex = 0;
    while ((foundItem = s.scan(itemPattern)) !== null) {
      if (typeof foundItem === 'string') { 
        let itemCode = s.nthSubgroup(1);

        if (itemCode !== null && itemCode !== empty) {
          // 0x6300 => 0x0063 => x99
          let itemQuantityHex = reverseHex(s.nthSubgroup(2) || '00');
          let itemQuantity = parseInt(itemQuantityHex, 16); // hex -> int
          let itemName = 'Unknown [' + itemCode + ']';
          let itemObject = codes[itemCode];
          // itemObject: item_name, item_category, item_valid
          if (itemObject !== undefined) { itemName = itemObject[0]; }
          let itemType = sectionName(sectionIndex);

          //  "#{item_name} x#{item_amount} (#{item_type}) [#{item_code}]"
          items.push(itemName + ' x' + itemQuantity + ' (' + itemType + ') [' + itemCode.toUpperCase() + ']');
        }

        if (s.peek(8) !== itemPattern8Bytes) {
          sectionIndex += 1;
          s.setPos(s.pos() + 8); // jump past '00 01 00 00' (section divider)
        }
       }
    }

    return items;
  }
}

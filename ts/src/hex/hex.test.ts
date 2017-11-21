import { hex } from './main';

// node.js apis are available in Jest... not in the browser
import * as fs from 'fs';
import { promisify } from 'util'; // promisify readFile for async/await
import { v118_items } from './v118_items'
const readFileAsync = promisify(fs.readFile);

it('adds two numbers', () => {
  expect(hex.add(1, 2)).toBe(3);
});

async function binToHex(binFilePath: string): Promise<string> {
  return await readFileAsync(binFilePath, { encoding: 'hex' });
}

it('reads a save file', async () => {
  // https://nodejs.org/api/buffer.html
  let data = await binToHex('./public/fake_item_file.bin');
  
  let expected = 'b269269167bce24440000000d8a2612d7820c83effffffffaaaa0000d8a2612d7820c83effffffffaaaa0000';
  expect(expected).toBe(data);
});

it('parses items', async () => {
  let data = await binToHex('./public/v1.18.save');
  let expected = v118_items; // generated with run_parse_inventory.rb#print_slot_json
  let actual = hex.parseItems(data);

  expect(actual.length).toBe(expected.length);

  actual.forEach((value, index) => {
    expect(actual[index]).toBe(expected[index]);
  });
});

/*
todo: export sample fake data from Ruby ...
todo: read in save file

todo: scan bytes for values

Find inventory start:
/B2 69 26 91 67 BC E2 44 40 00 00 00/x

then print item ids & counts:
/D8 A2 61 2D 78 20 C8 3E .. .. .. .. .. .. 00 00/x

maybe something like:
String.fromCharCode.apply(String, new Uint8Array(xhr.response));

or via node buffer class?

1x inventory start
2x inventory items

B2 69 26 91 67 BC E2 44  40 00 00 00 D8 A2 61 2D
78 20 C8 3E FF FF FF FF  AA AA 00 00 D8 A2 61 2D
78 20 C8 3E FF FF FF FF  AA AA 00 00

*/
### get ready

1. find a (packed) tile map i'll be using https://www.kenney.nl/assets/tower-defense-top-down
2. make a local copy with an easy name(in the folder with build.d) I will use kenny.png
3. make blob file to store meta data `./build.d blob/create.d kenny.png`
4. add the metadata to the blob file `./build.d blob/appendheader.d kenny.png tilewidth128` `./build.d blob/appendheader.d kenny.png tileheight128`
5. compile selector and verfiy your settings `./build.d -b source/selector.d ` `./selector kenny.png`

### (optional) add hotkeys

1. compile adddata.d `./build.d -b blob/adddata.d`
2. run makehotkeys on the blob `./makehotkeys.sh kenny.png`

### make a key file

The way I, doing auto tiling is via a example, simlair to "quatum wave collaspe" https://robertheaton.com/2018/12/17/wavefunction-collapse-algorithm/ ; except that I use 2 layers and its not some sudoku thing; each 3x3 of a lock has an example key; its your responiblity to make a map which covers all 3x3 cases you care about.

1. create the blob file while defining width and height `./build.d blob/createsize.d kennykey 64 64 2` (2 because there are 2 layers)
2. point at your tilemap at the blob file `./build.d blob/appendheader.d kennykey tilemapkenny.png`
3. open the key in the editor `./build.d source/editkey.d kennykey`

I suggest 2 tile wide circles

todo screenshots and key bindings

### draw

1. make input with create size then append a header to point at the key
2. source/app
3. todo keybinds and screen shots

### using the file

the output is a blob file theres a spefication and ulity file in blob/
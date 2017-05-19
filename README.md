# Stoichiometry
## Given a word, print the Elemental Spelling (if possible)
### About
This project aims to implement the general functionality of the algorithm found 
[here](https://www.amin.space/blog/2017/5/elemental_speller/).

### Requisites
- Haskell
- Make

### Building
Clone this repository, and then run
```bash
make all
```

The generated executable will be found in `bin/stoichiometry`.

### Usage
Simply run the executable with the word you wish to convert to elemental spelling and 
the program will return every possible elemental spelling of the word.

```bash
$ stoichiometry hearth
=> HeArTh
```
### Hyphenating Turkish Words

Examples:

```
>(hyphenate 'belirttirmek)
be-lirt-tir-mek
```
```
>(hyphenate 'avusturalyalilastiramadiklarimizdanmiymis)
a-vus-tu-ral-ya-li-las-ti-ra-ma-dik-la-ri-miz-dan-miy-mis
```

#### Algorithm

* Check two consequent letters in a word beginning from the end of a word
 * If vowel-vowel, hyphenate in the middle of them, print and continue
 * If consonant-consonant, print and continue
 * If vowel-consonant, print and and continue
 * If consonant-vowel, hyphenate at the beginning of that two letters, print and continue
* Check if there are any dashes in the first character of output
 * If yes, remove. If no, continue
* Check if the output is exception
 * If yes, combine the left consonants at the beginning with the first syllable. If no, print.

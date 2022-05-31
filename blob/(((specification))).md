## BLOB file format

* filenames end with .blob
* headers start with "BLOB file type ^tm\n"
* headers have whatever meta data as acsii text seperated by "\n"
* headers end with "END\n"

* ints are stored in whatever format `*(cast(char[4]*)(&int))` produces on my machine, 15= "0F 00 00 00"; my hex editor seems to disagree this is 15, so good luck

* theres a error checking int which is the sum and all the binary data % int.max

* after the error checking int the body is binary data as 32bit ints 


## details
* meta data should use these words in this order of importance for nd arrays: "width" "height" "depth" "strange" "charm" "truth" "beauty"

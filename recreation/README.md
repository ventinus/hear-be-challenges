I made this json_maker file to go through large text files that I needed to have access to through JavaScript. The text files included data regarding a large quantity of questions and answers from the Family Feud version on Super Nintendo. The format of the Q's and A's in the text file were as follows:

Tell me something specific you have lost more than once

Keys..................63

Money..................7

Weight.................5

Contact Lens...........4

Eyeglasses.............4

Wallet.................3

Earring................2


Name a toy you always see in pictures of Santa's Workshop

Doll..................39

Stuffed Animal........13

Train.................11

Rocking Horse..........9

Toy Soldier............9

Drum...................4

Ball...................3

Wagon..................3


My approach in was to first check if the line was empty which would move to the next line.
Then it checked for 2 symbols in a row which *mostly would be the '.....'. it would strip the dots away and separate the answer name from the answer votes, make an answer object to push into the array of answers of the question that was most recently created.
Else, it was a question and it woudl make a question object that had an array of answers belonging to it.

I then did some file-writing to a JSON file with the proper formatting from the data given to me. dealing with quotes caused some difficulty so i had to use %{} instead of some quotes because JSON requires "" and not ''. 
Issues I ran into in addition to the quotes with JSON formatting were also when certain words had quote "marks", which also had a comma so that's two symbols and it would think it's the two dots I wanted. This was fairly easily remedied since it only occured a handful of times and just had to double check the output around those sections was accurate. Also substituted all teh double-qoutes with single quotes becuase JSON doesn't like doubles inside a single value.
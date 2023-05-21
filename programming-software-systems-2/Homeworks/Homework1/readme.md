Name : Mosab Fathy Ramadan Mohamed

Group : B20-03

PSS II First Homework : 

Problem : 
  Given a string containing of several sentences and a list of words. 
  for each word in the list output the number of sentences that contain this word and then output these sentences.
  
Program : 
  Takes a string input and a list of different words.
  It calls the function Breaker.
      Breaker :  Takes a string and a reference to a vector of strings and breaks the string into several strings each one containing a sentence and pushes them into the vector of                  strings
  Loops over the list of words and at each iteration it calls the function Search.
      Search : Takes a string and a vector of strings, the word we are searching for and the vector of sentences.
               It goes through each sentence and looks for the word we are searching for and if we find it we rewrite it in uppercase and push it into a vector called ans.
               after finishing all the sentences it returns the vector ans
  Prints the size of the vector returned from the functions search, then it outputs the sentences where the word searched for is in uppercase.

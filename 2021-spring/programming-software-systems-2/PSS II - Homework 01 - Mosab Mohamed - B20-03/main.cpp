/*
 * Name : Mosab Fathy Ramadan Mohamed
 * Group : B20-03
 * Program : Takes a string input and a list of different words, for each word it should output how many sentences contains this word and prints the sentences with that word in uppercase
 * Date of access : 02/09/2021
 */
#include <bits/stdc++.h>

using namespace std;

/**
 * this function takes a string of multiple sentences and breaks them into separate sentences each one in a different string and puts them in the vector sentences
 *
 * @param str : string that holds the full one line input string
 * @param sentences : reference to a vector of strings that contains each sentence in a separate cell (initially empty)
 */
void Breaker(string str, vector<string> &sentences) {
    string word = "", sentence = "";
    for (int i = 0; i < str.size(); i++) {
        if (str[i] == ' ') {
            if (word[word.size() - 1] != '.') {
                sentence += word + " ";
            } else {
                sentence += word;
                sentences.push_back(sentence);
                sentence = "";
            }
            word = "";
            continue;
        } else {
            word += str[i];
        }
        if (i == str.size() - 1) {
            sentence += word;
            sentences.push_back(sentence);
        }
    }
}

/**
 * this function searches for a word in all the sentences we have and each sentences containing this word gets pushed into the final vector that will be returned to the caller
 *
 * @param word : the word that we are looking for
 * @param sentences : the sentences we have
 * @return : a vector containing the sentences that have the word specified in them
 */
vector<string> Search(string word, vector<string> sentences){
    vector<string> ans;

    for (int j = 0; j < sentences.size(); j++) {
        string cur = sentences[j];
        string temp = cur;
        bool in = false;
        for(int i=0;i<temp.size();i++){
            if(tolower(temp[i])==tolower(word[0])){
                bool yes = true;
                for(int k=0;k<word.size();k++){
                    if(tolower(temp[i+k])!=tolower(word[k])){
                        yes=false;
                    }
                }
                if(yes){
                    for(int k=0;k<word.size();k++){
                        temp[i+k]=toupper(temp[i+k]);
                    }
                    in = true;
                }
            }
        }
        if (in) {
            ans.push_back(temp);
        }
    }
    return ans;
}

int main() {
    /*
     * freopen is used to read and write from and to the files : in.txt and out.txt
     */
    freopen("in.txt", "r", stdin);
    freopen("out.txt", "w", stdout);

    string str;
    vector<string> sentences;
    vector<vector<string>> words;

    getline(cin, str); //getline is used to take the whole one line input

    Breaker(str, sentences);
    int n;
    cin >> n;
    for (int i = 0; i < n; i++) {
        string x;
        cin >> x;
        vector<string> result = Search(x,sentences);
        cout<<result.size()<<endl;
        for(int j=0;j<result.size();j++){
            cout<<result[j]<<endl;
        }
    }
    return 0;
}

#include <iostream>
#include <string>
#include <random>
#include <new>

using namespace std;

class guess {
	float Score;
	int length;
	string Word;

	public:
		float getScore() {
			return this->Score;
		}
		void setScore(float Score){
			this->Score = Score;
		}
		string getWord() {
			return this->Word;
		}
		void setWord(string Word) {
			this->Word = Word;
			this->length = sizeof(this->Word);
		}
		void set(string Word, float Score) {
			this->Word = Word;
			this->Score = Score;
			this->length = this->Word.length();
		}
		void set(string Word, float Score, int length) {
			this->Word = Word;
			this->Score = Score;
			this->length = length;
		}
		bool equals(guess compared) {
			return (this->Score == compared.getScore()) && (this->Word == compared.getWord());
		}
		int size() {
			return this->length;
		}
		int getLength() {
			this->length = this->Word.length();
			return this->length;
		}
		void addChar(string letter) {
			this->Word += letter;
			this->length++;
		}
		void addChar(char letter) {
			this->Word += letter;
			this->length++;
		}
		guess Copy() {
			guess nguess;
			nguess.set(this->Word, this->Score, this->length);
			return nguess;
		}
};

string Expected = "this is a test of the code";
guess matingPool[100000];
guess bestGuess;
int initSize = 1000;
int MatingPoolIndex = 0;
int MatingOverflowIndex = 0;

char randomChar() {
	int rnum = rand() % 27;

	if (rnum != 26)
		return('a' + rand() % 26);
	else
		return(' ');
}

float Grade(string guess) {//String Bug!!!
	float score = 0;

	for (int i = 0; i < guess.size(); i++) {
		//cout << guess.substr(i, 1) << endl;
		if (guess.substr(i, 1) == Expected.substr(i, 1))
			score += 1;
		else
			score -= 1 / 3;
	}

	if (score < 0)
		score = 0;

	//cout << Expected << " || " << guess << ", " << score << endl;

	for (int i = 0; i < score; i++) {
		if ((MatingPoolIndex + 1) >= (sizeof(matingPool) / sizeof(matingPool[0]))) {
			matingPool[MatingOverflowIndex].set(guess, score);
			MatingOverflowIndex++;

			if (MatingOverflowIndex >= MatingPoolIndex)
				MatingOverflowIndex = 0;
		}
		else {
			matingPool[MatingPoolIndex].set(guess, score);
			MatingPoolIndex++;
		}
	}
	if (score > bestGuess.getScore())
		bestGuess.set(guess, score);

	return score;
}

void breed() {
	guess parents[2] = {
		matingPool[rand() % MatingPoolIndex],
		matingPool[rand() % MatingPoolIndex]
	};
	

	int Count = 0;
	while (parents[0].equals(parents[1])) {
		parents[1] = matingPool[rand() % MatingPoolIndex];
		if (Count >= 100) {
			cout << "Breed Loop Overrun!!!" << endl;
			break;
		}
		Count++;
	}

	//cout << parents[0].size()+1 << endl;

	guess result;
	for (int i = 0; i < parents[0].size(); i++) {

		//cout << i << ": " << parents[0].getWord().substr(i, 1) << endl;
		if (rand() % 100 != 0) {
			result.addChar(parents[rand()%2].getWord().substr(i, 1));
		}
		else {
			result.addChar(randomChar());
		}
	}

	result.setScore(Grade(result.getWord()));
}

void initalguess() {
	string str = "";
	for (int i = 0; i < Expected.size(); i++)
		str += randomChar();

	matingPool[MatingPoolIndex].set(str, Grade(str));
	MatingPoolIndex++;

	//cout << str << endl;
}

guess lastGuess;

int main() {
	//Entry
	cout << "Generating initial Population" << endl;
	cout << "_____________________________" << endl;

	for (int i = 0; i < initSize; i++) {
		initalguess();
	}

	cout << "end initial Generation" << endl;

	while (true) {//Loop

		if (bestGuess.getScore() != Expected.length())
			breed();
		else
			break;

		//cout << bestGuess.getScore() << ", " << Expected.length() << " || " << bestGuess.getWord() << " || " << Expected << endl;
		
		if (!lastGuess.equals(bestGuess)) {
			cout << bestGuess.getScore() << " || " << bestGuess.getWord() << endl;
			cout << Expected.length() << " || " << Expected << endl;
			cout << "=============================================================" << endl;
		}
		lastGuess = bestGuess.Copy();
	}

	cout << "Finished!!!" << endl;
}

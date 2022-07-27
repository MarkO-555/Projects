#include <iostream>
#include <string>
#include <random>
#include <new>

class guess {
	float Score;
	int length;
	std::string Word;

	public:
		float getScore() {
			return this->Score;
		}
		void setScore(float Score){
			this->Score = Score;
		}
		std::string getWord() {
			return this->Word;
		}
		void setWord(std::string Word) {
			this->Word = Word;
			this->length = sizeof(this->Word);
		}
		void set(std::string Word, float Score) {
			this->Word = Word;
			this->Score = Score;
			this->length = this->Word.length();
		}
		void set(std::string Word, float Score, int length) {
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
		void addChar(std::string letter) {
			this->Word += letter;
			length++;
		}
		void addChar(char letter) {
			this->Word += letter;
			length++;
		}
		guess Copy() {
			guess nguess;
			nguess.set(this->Word, this->Score, this->length);
			return nguess;
		}
};

std::string Expected = "testing";
guess matingPool[100];
guess bestGuess;
int initSize = 10;
int MatingPoolIndex = 0;
int MatingOverflowIndex = 0;

char randomChar() {
	return ('a' + rand() % 26);
}

float Grade(std::string guess) {
	float score = 0;

	for (int i = 0; i < guess.size(); i++) {
		//std::cout << guess.substr(i, 1) << std::endl;
		if (guess.substr(i, 1) == Expected.substr(i, 1))
			score += 2;
		else
			score -= 1 / 3;
	}

	if (score < 0)
		score = 0;

	//std::cout << Expected << " || " << guess << ", " << score << std::endl;

	for (int i = 0; i < score; i++) {
		if (MatingPoolIndex <= 2 + (sizeof(matingPool) / sizeof(matingPool[0]))){
			matingPool[MatingOverflowIndex].set(guess, score);
			MatingOverflowIndex++;
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
			std::cout << "Breed Loop Overrun!!!" << std::endl;
			break;
		}
		Count++;
	}

	//std::cout << parents[0].size()+1 << std::endl;

	guess result;
	for (int i = 0; i < parents[0].size(); i++) {

		//std::cout << i << ": " << parents[0].getWord().substr(i, 1) << std::endl;
		if (rand() % 100 != 0) {
			result.addChar(parents[rand()%2].getWord().substr(i, 1));
		}
		else {
			result.addChar(randomChar());
		}
	}

	result.setScore(Grade(result.getWord()));

	std::cout <<parents[0].getWord() << ", " << parents[1].getWord() << " || " << result.getWord() << " || " << Expected << std::endl;
}

void initalguess() {
	std::string str = "";
	for (int i = 0; i < Expected.size(); i++)
		str += randomChar();

	matingPool[MatingPoolIndex].set(str, Grade(str));
	MatingPoolIndex++;

	//std::cout << str << std::endl;
}

int main() {
	//Entry
	std::cout << "Generating initial Population" << std::endl;
	std::cout << "_____________________________" << std::endl;

	for (int i = 0; i < initSize; i++) {
		initalguess();
	}

	std::cout << "end initial Generation" << std::endl;

	while (true) {//Loop
		if (bestGuess.getScore() != Expected.length())
			breed();
		else
			break;
	}
}

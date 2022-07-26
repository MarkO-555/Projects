#include <iostream>
#include <string>

class guess {
	float Score;
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
		}
};

std::string Expected = "testing";
guess matingPool[100];
int MatingPoolIndex = 0;

float floats[100];

float Grade(std::string guess) {
	float score = 0;

	for (int i = 0; i < guess.size(); i++) {
		guess.substr(i, 1);
	}

	return 0;
}

void Makeguess() {
	std::string str = "";
	for (int i = 0; i < Expected.size(); i++)
		str += ('a' + rand() % 26);

	matingPool[MatingPoolIndex].setWord(str);
	matingPool[MatingPoolIndex].setScore(Grade(str));

	MatingPoolIndex++;
}


void init() {
	//std::cout << "Starting program";
	std::cout << "Generating initial Population" << std::endl;
	std::cout << "_____________________________" << std::endl;

	for (int i = 0; i < sizeof(matingPool) / sizeof(matingPool[0]); i++) {
		Makeguess();
	}
	 
	std::cout << "end initial Generation";
}

bool loop() {
	//std::cout << randomString() << " || " << Expected << std::endl;
	return false;
}


int main() {
	init();
	while (true) {

		if (!loop())
			break;
	}
}

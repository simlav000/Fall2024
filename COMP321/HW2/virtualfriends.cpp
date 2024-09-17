#include <iostream>
#include <unordered_map>
using namespace std;

struct person {
    person* representative;
    string name;
    int network_size;

    person(string name): name(name), representative(this), network_size(1)  {}

    person* find() {
        if (this->representative != this) {
            this->representative = this->representative->find();
        }
        return this->representative;
    }

    void unite(person* p) {
        person* rep1 = this->find();
        person* rep2 = p->find();

        if (rep1 != rep2) {
            rep2->representative = rep1;
            rep1->network_size += rep2->network_size;
        }

    }
};

int main() {
    int num_cases;
    int num_friendships;

    cin >> num_cases;
    while (num_cases--) {
        unordered_map<string, person*> people;
        cin >> num_friendships;
        for (int i = 0; i < num_friendships; i++) {
            string name1;
            string name2;

            cin >> name1;
            cin >> name2;

            person* p1;
            person* p2;
            if (people.find(name1) == people.end()) {
                 p1 = new person(name1);
                people[name1] = p1;
            }
            else {
                p1 = people.at(name1);
            }
            if (people.find(name2) == people.end()) {
                p2 = new person(name2);
                people[name2] = p2;
            }
            else {
                p2 = people.at(name2);
            }

            p1->unite(p2);

            cout << p1->representative->network_size << endl;
        }
    }
}

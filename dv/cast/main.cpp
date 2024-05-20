#include <iostream>
using namespace std;

class root {
public:
    virtual ~root () { }
    virtual void print () {
        cout << "is root" << endl;
    }
};

class stem : public root {
public:
    virtual print () {
        cout << "is stem" << endl;
    }
}

class leaf : public stem {
public:
    virtual print () {
        cout << "is leaf" << endl;
    }
}

int main() {
    root* root_p = new root;
    leaf* leaf_p = new leaf;

    stem* stem_root_p = dynamic_case<stem*>(root);
    stem* stem_left_p = dynamic_case<stem*>(stem);
}

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
    virtual void print () {
        cout << "is stem" << endl;
    }
};

class leaf : public stem {
public:
    virtual void print () {
        cout << "is leaf" << endl;
    }
};

int main() {
    root* root_p = new root;
    leaf* leaf_p = new leaf;
    root* root_stem_p = new stem;

    stem* stem_root_p = dynamic_cast<stem*>(root_p);
    stem* stem_leaf_p = dynamic_cast<stem*>(leaf_p);
    stem* stem_root_stem_p = dynamic_cast<stem*>(root_stem_p);
    stem* stem_stem_leaf_p = dynamic_cast<stem*>(stem_leaf_p);

    cout << "pointer display 0 means fatal." << endl;
    cout << "stem_root_p:" << stem_root_p << endl;
    cout << "stem_leaf_p:" << stem_leaf_p << endl;
    cout << "stem_root_stem_p:" << stem_root_stem_p << endl;
    cout << "stem_stem_leaf_p:" << stem_stem_leaf_p << endl;

    return 0;
}

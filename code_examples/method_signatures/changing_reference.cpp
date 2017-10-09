#include <iostream>

class Foo {
public:
    void foobar(int& e_value);
};

void Foo::foobar(int& e_value) {
    if (e_value != 42) {
        e_value = 42;
    }
}

int main(int argc, const char * argv[]) {
    Foo instance = Foo();
    int value;
    instance.foobar( value );
    std::cout << value << "\n";
    return 0;
}

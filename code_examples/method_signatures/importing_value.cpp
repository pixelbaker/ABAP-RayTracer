#include <iostream>

class Foo {
public:
    void foobar(const int i_value);
};

void Foo::foobar(const int i_value) {
    std::cout << i_value << "\n";
}

int main(int argc, const char * argv[]) {
    Foo instance = Foo();
    int value = 42;
    instance.foobar( value );
    return 0;
}

#include <iostream>

class Foo {
public:
    int& foobar();
};

int& Foo::foobar() {
    return *(new int(42));
}

int main(int argc, const char * argv[]) {
    Foo instance = Foo();
    int value = instance.foobar( );
    std::cout << value << "\n";
    return 0;
}

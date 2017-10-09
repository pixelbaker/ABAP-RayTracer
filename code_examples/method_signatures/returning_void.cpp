#include <iostream>

class Foo {
public:
    void foobar();
};

void Foo::foobar() {
    std::cout << "Total bore!\n";
}

int main(int argc, const char * argv[]) {
    Foo instance = Foo();
    instance.foobar( );
    return 0;
}

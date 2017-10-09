#include <iostream>

class Foo {
public:
    void foobar(int* e_value);
};

void Foo::foobar(int* e_value) {
    *e_value = 42;
}

int main(int argc, const char * argv[]) {
    Foo instance = Foo();
    int value;
    int* value_ptr = &value;
    instance.foobar( value_ptr );
    std::cout << value << "\n";
    return 0;
}

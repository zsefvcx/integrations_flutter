#include <iostream>
#include <string>

int get_len(String str){
    std::cout << "rcv:" << str << std::endl;

    return str.length();
}
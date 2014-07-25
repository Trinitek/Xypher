
asm("org 32768");
asm("jmp _main");

char greeting[] =
    "Xypher Windowing Library Loader\r\n"
    "Version 1.0\r\n"
    "Copyright (c) 2014 Blake Burgess\r\n";

void main(void) {
    // Display greeting string
    os_printString(&greeting);
}

#include "mikedev.c"


asm("%include 'mikedev.inc'");

void os_printString(char *stringPtr) {
    asm("mov si, [bp + 4]\n"
        "call os_print_string");
}

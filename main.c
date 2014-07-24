
asm("org 32768");

void main(void) {
    asm("mov ah, 0x0E\n"
        "mov al, 'A'\n"
        "int 0x10");
}

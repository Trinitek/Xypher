
/* Macros and directives */
asm("%define CR 0x0D");
asm("%define LF 0x0A");

asm("org 32768");
asm("jmp _main");

/* Global data */
char greeting;
    asm("db '===========================',CR,LF");
    asm("db 'Xypher Windowing API Loader',CR,LF");
    asm("db '===========================',CR,LF");
    asm("db 'Version 1.0',CR,LF");
    asm("db 'Copyright (c) 2014 Blake Burgess',CR,LF,0");
char alreadyInstalled[] =
    "Xypher is already in memory.\r\n";
char success[] =
    "Xypher successfully loaded. Hooked into interrupt 0x45.\r\n";

/* Main program */
void main(void) {
    // Display greeting message
    os_printString(&greeting + 1);

    // Check to see if the API is in memory
    asm("checkIfInstalled:");

    asm("mov ah, 0x00\n"
        "int 0x45\n"
        "cmp al, 0x88\n"
        "je .present\n"
        "jmp .absent");

    // API is already installed
    asm(".present:");
        os_printString(&alreadyInstalled);
        return;

    // API is not present
    asm(".absent:");
        // Load the interrupt handler at the next full segment
        asm("push es\n"
            "mov dx, ds\n"
            "add dx, 4096\n"
            "mov es, dx\n"      // keep handler segment in DX for next step
            "xor di, di\n"
            "mov si, intHandler\n"
            "mov cx, eof - intHandler\n"
            "rep movsb\n");

        // Hook into interrupt 0x45
        asm("cli\n"             // disable interrupts
            "xor ax, ax\n"
            "mov es, ax\n"
            "mov di, 0x114\n"   // interrupt number * 4
            "stosw\n"           // offset goes in first
            "mov ax, dx\n"
            "stosw\n"           // segment goes in second
            "sti\n");           // re-enable interrupts

        // Setup Xypher environment variables
        /*asm("mov ah, 0x02\n"
            "mov bx, ds\n"      // BX = userspace segment
            "mov cx, dx\n"      // CX = Xypher segment
            "int 0x45\n"
            "pop es");*/

        /*asm("mov ah, 0x03\n"
            "int 0x45\n"
            "call os_dump_registers");*/

        asm("pop es");

        // Done!
        os_printString(&success);
        return;
}

/* System functions */
asm("%include 'mikedev.inc'");

void os_printString(char *stringPtr) {
    asm("mov si, [bp + 4]\n"
        "call os_print_string");
}


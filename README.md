####Xypher
#####Windowing API for the MikeOS operating system

Xypher provides an interface for drawing complex GUI-like windows in a textmode environment. With handling window elements being the primary focus of this software in addition to its ability to draw a number of 2D primitives, it is able to handle things such as textboxes, buttons, checks, and radio selections as specified by the host application, and position them on the screen.

Aside from its ability to handle GUI-like windows, Xypher separates itself from rudimentary textmode graphics libraries in that it can intelligently place elements on the screen. You can specify a location relative to another object or within logical bounding boxes, and there is no unspecified behavior when the application decides to place an object outside of the screen area or even where part of it is clipped off of the screen. The object is clipped accordingly. This eliminates the developer's need to perform location and size checks that cost the program scarce and expensive memory space: simply plug in the information and go.

On the technical implementation side of things, Xypher is designed to be accessible through interrupt calls. A loader program saves the library to memory and latches into interrupt 0x45, freeing the application from having to host the library within itself.

Xypher is not, and does not try to be, a window manager of any sort. It simply provides a user interface that is consistent across applications that choose to utilize it. Any sort of user response must still be handled by the host application. Even in situations where you wish to resize a window, the application must specify the new window size, and Xypher will try to position and fit the contained elements accordingly.

#include <ruby.h>

VALUE ext0_int(VALUE self) {
    /*
    #INT2NUM

        Convert integer into Fixnum or Bignum.

        A large int may still become Bignum because
        Fixnum can only contain half of the int range.
    */
    return INT2NUM(0);
}

/*
#Init_

    The function `Init_extname` is magic and gets called at load time.

    The main usage of this method is to export visible objects to Ruby.
*/
void Init_ext0() {

    /*
    #rb_define_global_function

        Will be visible at the toplevel.

        Should seldom be used.
    */
    rb_define_global_function("ext0_int", ext0_int, 0);
}

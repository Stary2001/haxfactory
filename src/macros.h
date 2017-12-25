/* freakyforms qr code exploit. */
/* plutoo 2016 */
#define GARBAGE 0xDEADC0DE

#if defined(EUR)
#define REGION_CONST(name, eur, usa) .set name, eur
#elif defined(USA)
#define REGION_CONST(name, eur, usa) .set name, usa
#else
#error "wat"
#endif

#define GLOBAL_CONST(name, val) .set name, val
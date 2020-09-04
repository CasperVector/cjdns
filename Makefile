NODEJS = node
REF10 = $(wildcard crypto/sign/*.c)
CFLAGS = -g -Wall -Wextra -Werror -Wmissing-prototypes \
	-Wno-pointer-sign -Wno-unused-parameter
LDLIBS = -lsodium -luv

include jscfg.mk

%.o: %.i
	$(CC) $(O_FLAGS) $(CFLAGS) $(X_CFLAGS) -c -o $@ $<

%.i: %.ii
	$(NODEJS) ./jsmacro.js $< $@

%.ii: %.c
	$(CC) -E $(O_FLAGS) $(CPPFLAGS) $(X_CPPFLAGS) -o $@ $<

# Cancel out the implicit rule
%.o: %.c

# Do not auto-remove .i and .ii files
.SECONDARY:

crypto/CryptoAuth.o: X_CFLAGS = -Wno-unused-result
$(REF10:.c=.ii): X_CPPFLAGS = -I./crypto/sign

-include config.mk


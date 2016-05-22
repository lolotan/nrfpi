PROJECT = nrf
LIBNRF = libnrf
NRFSTATICLIB = $(LIBNRF).a
EXECUTABLE = $(PROJECT)test
MAIN = main
OBJECTS = $(LIBNRF)/$(NRFSTATICLIB) spi.o gpio.o timer.o

all: $(EXECUTABLE)

$(EXECUTABLE): $(NRFSTATICLIB) $(MAIN).o $(OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(MAIN).o $(OBJECTS) -o $(EXECUTABLE)

$(NRFSTATICLIB):
	$(MAKE) -C $(LIBNRF)
	
$(MAIN).o: $(MAIN).c
	$(CC) $(CFLAGS) -c $(MAIN).c
	
spi.o: spi.c
	$(CC) $(CFLAGS) -c spi.c

gpio.o: gpio.c
	$(CC) $(CFLAGS) -c gpio.c
	
timer.o: timer.c
	$(CC) $(CFLAGS) -c timer.c
	
clean:
	rm -rf *.o *.a $(EXECUTABLE)
	 $(MAKE) -C $(LIBNRF) clean


.PHONY: $(LIBNRF)

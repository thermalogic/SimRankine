
BIN=./bin/
INC=./include/
LIBFLAGS=-L./bin -lseuif97
ifneq ($(OS),Windows_NT)
	UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        LIBFLAGS += -Wl,-rpath=./bin
    endif
endif

CFLAGES=-std=c++17 -O3  

SRCS=./rankinesim.cpp \
	./src/rankine.cpp \
	./src/port.cpp \
	./src/connector.cpp \
	./src/turbineex0.cpp \
	./src/turbineex1.cpp \
	./src/openedheaterdw0.cpp \
	./src/condenser.cpp \
	./src/pump.cpp \
	./src/boiler.cpp 

OUTFILE=./bin/rankinesim

all: $(OUTFILE)
	$(OUTFILE)

$(OUTFILE): $(SRCS)  
	g++ $(CFLAGES) -o $@ $^ -I$(INC) $(LIBFLAGS)

run:
	$(OUTFILE)


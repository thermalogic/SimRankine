
BIN=./bin/
INC=./include/
LIBFLAGS=-L./bin -lseuif97
CFLAGES=-std=c++17 -O3  

SRCS=./demorankine81.cpp \
	./src/rankine.cpp \
	./src/port.cpp \
	./src/connector.cpp \
	./src/turbineex0.cpp \
	./src/condenser.cpp \
	./src/pump.cpp \
	./src/boiler.cpp 

OUTFILE=./bin/rankine81

all: $(OUTFILE)
	$(OUTFILE)

$(OUTFILE): $(SRCS)  
	g++ $(CFLAGES) -o $@ $^ -I$(INC) $(LIBFLAGS)

run:
	$(OUTFILE)


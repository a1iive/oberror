GCC = g++
CC  = gcc
FLAGS = -g -W -Wall
GCCFLAGS = -std=c++11
DEFINES = 
LIBS    = 
LINK = g++
LINKFLAGS =
HEADER  =

OBJECT = src/ob_error.o \
		 src/ob_errno.o \
		 src/os_errno.o

.PHONY: clean

TARGET = ob_error

$(TARGET): $(OBJECT)
	$(LINK) $(FLAGS) $(LINKFLAGS) -o $@ $^ $(LIBS)

# 编译cpp代码用这个目标
%.o: %.cpp
	$(GCC) -c $(HEADER) $(FLAGS) $(GCCFLAGS) $< -o $@

# 编译c代码用这个
%.o: %.c
	$(CC) -c $(HEADER) $(FLAGS) $< -o $@

clean:
	rm -rf $(TARGET) $(OBJECT)

INSTALL_PATH := /usr/local/bin

install: $(TARGET)
	cp $(TARGET) $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)/$(TARGET)
GCC = g++
CC  = gcc
FLAGS = -g -W -Wall
GCCFLAGS = -std=c++11
DEFINES = 
LIBS    = 
LINK = g++
LINKFLAGS =
HEADER  =

SOURCES = src/os_errno.cpp \
	      src/ob_errno.cpp \
	      src/ob_error.cpp 

SRC_PATH = src
OBJ_PATH = build
BIN_PATH = build/bin

OBJECT = $(patsubst %.cpp,$(OBJ_PATH)/%.o, $(notdir $(SOURCES)))

.PHONY: clean

TARGET = ob_error

test = $(shell if [ -d $(BIN_PATH) ]; then echo "exist"; else echo "noexist"; fi)

ifeq ("$(test)", "noexist")
$(shell mkdir $(BIN_PATH))
endif

$(BIN_PATH)/$(TARGET): $(OBJECT)
	$(LINK) $(FLAGS) $(LINKFLAGS) $^ -o $@ $(LIBS)

# 编译cpp代码用这个目标
$(OBJ_PATH)/%.o: $(SRC_PATH)/%.cpp
	$(GCC) -c $(HEADER) $(FLAGS) $(GCCFLAGS) $< -o $@

# 编译c代码用这个
# $(OBJ_PATH)/%.o: %.c
#	$(CC) -c $(HEADER) $(FLAGS) $< -o $@

clean:
	rm -rf $(OBJ_PATH)/*

INSTALL_PATH := /usr/local/bin

install: $(BIN_PATH)/$(TARGET)
	cp $(BIN_PATH)/$(TARGET) $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)/$(TARGET)
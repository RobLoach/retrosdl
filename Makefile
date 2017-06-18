OBJS = retros.cpp
CC = g++

#COMPILER_FLAGS specifies the additional compilation options we're using
# -w suppresses all warnings
COMPILER_FLAGS =

#LINKER_FLAGS specifies the libraries we're linking against
LINKER_FLAGS = -lSDL2 -lGL -lGLEW -ldl -lasound

#OBJ_NAME specifies the name of our exectuable
OBJ_NAME = retros

#This is the target that compiles our executable
all: $(OBJS)
	$(CC) $(OBJS) $(COMPILER_FLAGS) $(LINKER_FLAGS) -o $(OBJ_NAME)

clean:
	rm -rf tmp retros

tmp:
	mkdir -p tmp

tmp/cavestory.zip: tmp
	wget -O tmp/cavestory.zip https://buildbot.libretro.com/assets/cores/NXEngine/Cave%20Story%20%28en%29.zip

tmp/Cave\ Story\ \(en\)/Doukutsu.exe: tmp/cavestory.zip
	unzip -o tmp/cavestory.zip -d tmp

pretest: tmp/Cave\ Story\ \(en\)/Doukutsu.exe tmp/nxengine_libretro.so

test: all
	@-./retros /usr/lib/libretro/nxengine_libretro.so tmp/Cave\ Story\ \(en\)/Doukutsu.exe || true

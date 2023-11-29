CC 	= g++
CFLAGS	= -Wall
LD	= $(CC)
LDFLAGS = #unused
# LDFLAGS = -static
RM	= rm

EXE 	= Tetris
SRCS 	= Piece.cpp Board.cpp TetrisGame.cpp main.cpp
OBJS	= ${SRCS:.cpp=.o}

# WXFLAGS = `wx-config --cppflags`
# WXLINK 	= `wx-config --libs`
WXFLAGS = `wx-config --static --cppflags`
WXLINK 	= `wx-config --static --libs`

.SUFFIXES: #clear them just in case
.SUFFIXES: .o .cpp

all : $(EXE)

depend : .depend

.depend : $(SRCS)
	$(CC) $(CFLAGS) -MM $^ > .depend

include .depend

.cpp.o :
	$(CC) $(WXFLAGS) $(CFLAGS) -c $<

$(EXE) : $(OBJS)
	# $(LD) -o $@ $(OBJS) $(WXLINK)
	$(LD) -static -o $@ $(OBJS) $(WXLINK)

TAGS : $(SRCS)
	find . -regex ".*\.[cChH]\(pp\)?" -print | etags -

.PHONY : clean
clean :
	-$(RM) $(EXE) $(OBJS) .depend TAGS

.PHONY: docker-build
docker-build:
	docker build -t wxtetris .

.PHONY: docker-run
docker-run:
	docker run -it -p 8080:8080 wxtetris

.PHONY: docker-build-and-run
docker-build-and-run:
	docker build -t wxtetris . && docker run -it -p 8080:8080 wxtetris

.PHONY: docker-delete
docker-delete:
	docker rm $(docker stop $(docker ps -a -q --filter ancestor=wxtetris --format="{{.ID}}"))

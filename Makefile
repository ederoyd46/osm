all: update_deps generate_protobuf install

install:
	go install ./fileformat
	go install ./osmformat

init_dir:
	@mkdir -p osmformat fileformat

clean_up:
	-@rm -rf osmformat fileformat

update_deps:
	go get -u github.com/golang/protobuf/proto
	go get -u github.com/golang/protobuf/protoc-gen-go

generate_protobuf: init_dir
	@protoc --go_out=. osmformat.proto
	@protoc --go_out=. fileformat.proto
	@mv osmformat*.go osmformat
	@mv fileformat*.go fileformat

build:
	@find . -name '*.go' -exec go build {} \;

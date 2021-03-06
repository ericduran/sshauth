GO	:= $(shell which go)
bin	= sshauth

.PHONY: build
build: $(GO)
	$(GO) build -o $(bin)

.PHONY: setup
setup: $(GO)
	$(GO) get "github.com/google/go-github/github"
	$(GO) get "golang.org/x/oauth2" 
	$(GO) get "golang.org/x/net/context" 

clean:
	rm -f $(bin)

install: $(bin)
	cp $(bin) /usr/local/sbin/
	chmod 555 /usr/local/sbin/$(bin)
	mkdir -p /etc/sshauth
	chmod 750 /etc/sshauth
	chown root:root /etc/ssh/sshauth
	cp config.example /etc/sshauth/
	chmod 440 /etc/sshauth/config.example

#- development targets

.PHONY: run
run: build
	./$(bin) --config ./config.json


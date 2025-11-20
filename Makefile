TEST_EXTS += tex html txt
TEST_OUT += $(addprefix test_cache/test_gen.,$(TEST_EXTS))
EMACS ?= emacs
INIT_EL = "(require 'batch-ox)"
CONVERT += $(EMACS) -Q --batch -L . --eval $(INIT_EL)

define EXAMPLE_FILE
#+TITLE: Test batch-ox.el
#+AUTHOR: Batch-OX

* Success
This test succeeded!
endef

export EXAMPLE_FILE

.PHONY: check
check: $(TEST_OUT)

test_cache/test_gen.%: test_cache/test.org batch-ox.el
	@echo "Exporting to: $@"
	$(CONVERT) --eval '(batch-ox-export "$@" "$<")'

test_cache/test.org:
	[ -d test_cache ] || mkdir test_cache

	echo "$$EXAMPLE_FILE" > "$@"

.PHONY: clean
clean:
	rm -rf test_cache
